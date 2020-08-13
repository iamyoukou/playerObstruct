#include "common.h"

int main(int argc, char **argv) {
  // import data
  Assimp::Importer importer;

  string fileName = "./mesh/quad.obj";
  const aiScene *scene = importer.ReadFile(fileName, 0);

  if (!scene) {
    std::cout << "Cannot read file " << fileName << '\n';

    return EXIT_FAILURE;
  }

  // print mesh info
  std::cout << "# of meshes: " << scene->mNumMeshes << '\n' << '\n';

  for (size_t i = 0; i < scene->mNumMeshes; i++) {
    const aiMesh *mesh = scene->mMeshes[i];

    std::cout << "Mesh " << i << ": " << mesh->mName.C_Str() << '\n';

    std::cout << "mVertices: " << '\n';
    for (size_t i = 0; i < mesh->mNumVertices; i += 3) {
      std::cout << "(" << mesh->mVertices[i].x << ", " << mesh->mVertices[i].y
                << ", " << mesh->mVertices[i].z << ") ";

      std::cout << "(" << mesh->mVertices[i + 1].x << ", "
                << mesh->mVertices[i + 1].y << ", " << mesh->mVertices[i + 1].z
                << ") ";

      std::cout << "(" << mesh->mVertices[i + 2].x << ", "
                << mesh->mVertices[i + 2].y << ", " << mesh->mVertices[i + 2].z
                << ") " << '\n';
    }

    std::cout << "mNormals: " << '\n';
    for (size_t i = 0; i < mesh->mNumVertices; i += 3) {
      std::cout << "(" << mesh->mNormals[i].x << ", " << mesh->mNormals[i].y
                << ", " << mesh->mNormals[i].z << ") ";

      std::cout << "(" << mesh->mNormals[i + 1].x << ", "
                << mesh->mNormals[i + 1].y << ", " << mesh->mNormals[i + 1].z
                << ") ";

      std::cout << "(" << mesh->mNormals[i + 2].x << ", "
                << mesh->mNormals[i + 2].y << ", " << mesh->mNormals[i + 2].z
                << ") " << '\n';
    }

    std::cout << "mTextureCoords: " << '\n';
    for (size_t i = 0; i < mesh->mNumVertices; i += 3) {
      std::cout << "(" << mesh->mTextureCoords[0][i].x << ", "
                << mesh->mTextureCoords[0][i].y << ", "
                << mesh->mTextureCoords[0][i].z << ") ";

      std::cout << "(" << mesh->mTextureCoords[0][i + 1].x << ", "
                << mesh->mTextureCoords[0][i + 1].y << ", "
                << mesh->mTextureCoords[0][i + 1].z << ") ";

      std::cout << "(" << mesh->mTextureCoords[0][i + 2].x << ", "
                << mesh->mTextureCoords[0][i + 2].y << ", "
                << mesh->mTextureCoords[0][i + 2].z << ") " << '\n';
    }

    std::cout << '\n';
  }

  return EXIT_SUCCESS;
}
