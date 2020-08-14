#version 330

in vec2 uv;
in vec3 worldPos;
in vec3 worldN;

// uniform sampler2D texDepth;
uniform vec3 lightColor;
uniform vec3 lightPosition;
uniform vec3 eyePoint;
uniform float beta;

float ka = 0.1, kd = 0.75, ks = 0.25;
float alpha = 20;

vec3 baseColor = vec3(0, 0.5, 0);
vec4 occlusionColor = vec4(0, 1, 0, 1);

out vec4 outputColor;

void main() {

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

  outputColor += ambient;
  outputColor += diffuse * dc * attenuation;
  outputColor += specular * sc * attenuation;

  outputColor = mix(outputColor, occlusionColor, beta);
  // outputColor = vec4(beta);
}
