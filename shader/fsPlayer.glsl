#version 330

in vec2 uv;
in vec3 worldPos;
in vec3 worldN;
in vec4 clipSpace;

uniform sampler2D texDepth;
uniform vec3 lightColor;
uniform vec3 lightPosition;
uniform vec3 eyePoint;
uniform int GREATER;

float ka = 0.1, kd = 0.75, ks = 0.25;
float alpha = 20;

vec3 baseColor = vec3(0, 0.5, 0);

out vec4 outputColor;

void main() {
  // after [-1, 1] to [0, 1],
  // ndc will be the uv coordinates of the current fragment on the screen
  vec2 ndc = vec2(clipSpace.x / clipSpace.w, clipSpace.y / clipSpace.w);
  ndc = ndc / 2.0 + 0.5;

  vec3 N = worldN;
  vec3 L = normalize(lightPosition - worldPos);
  vec3 V = normalize(eyePoint - worldPos);
  vec3 H = normalize(L + V);

  outputColor = vec4(0);

  vec4 ambient = ka * vec4(baseColor, 0.0);
  vec4 diffuse = kd * vec4(baseColor, 0.0);
  vec4 specular = vec4(lightColor * ks, 1.0);

  float dist = length(L);
  float attenuation = 1.0 / (dist * dist);
  float dc = max(dot(N, L), 0.0);
  float sc = pow(max(dot(H, N), 0.0), alpha);

  // glDepthFunc(GL_GREATER)
  if (GREATER == 1) {
    float sceneDepth = texture(texDepth, ndc.xy).r;

    float playerDepth = gl_FragCoord.z;
    float diff = max(playerDepth - sceneDepth, 0);

    // use a threshold
    // because the difference between two floats will never be zero
    if (diff > 0.0001) {
      outputColor = vec4(0, 1, 0, 0);
    } else {
      discard;
    }
  }
  // glDepthFunc(GL_LESS)
  else {
    outputColor += ambient;
    outputColor += diffuse * dc * attenuation;
    outputColor += specular * sc * attenuation;
  }
}
