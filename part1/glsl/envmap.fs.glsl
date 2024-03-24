in vec3 vcsNormal;
in vec3 vcsPosition;

uniform vec3 lightDirection;

uniform samplerCube skybox;

uniform mat4 matrixWorld;

void main( void ) {

  // Q1c : Calculate the vector that can be used to sample from the cubemap
  // TODO:
  vec4 tcolor = textureCube(skybox, vcsNormal);
  gl_FragColor = tcolor;
}