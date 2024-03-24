out vec3 vcsNormal;
out vec2 texCoord;
out vec3 vcsPosition;

void main() {
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
    vcsNormal = normalMatrix * normal;
    texCoord = uv;
    vcsPosition = vec3(modelViewMatrix * vec4(position, 1.0));
 }