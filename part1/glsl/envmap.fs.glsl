in vec3 vcsNormal;
in vec3 vcsPosition;

uniform vec3 lightDirection;

uniform samplerCube skybox;

uniform mat4 matrixWorld;

void main( void ) {

  // Q1c : Calculate the vector that can be used to sample from the cubemap
  // TODO:
  vec3 normal = normalize(vcsNormal);
  vec3 reflected = vec3(matrixWorld * vec4(reflect(normalize(vec3(vcsPosition)), normal), 0.0));
  vec4 tcolor = textureCube(skybox, reflected);
  gl_FragColor = tcolor;
}