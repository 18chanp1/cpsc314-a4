//Q1d implement the whole thing to map the depth texture to a quad
// TODO:

uniform mat4 lightProjMatrix;
uniform mat4 lightViewMatrix;

out vec4 screenPos;
out vec2 texCoord;

void main() {
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4( position, 1.0 );
    screenPos =  projectionMatrix * viewMatrix * modelMatrix * vec4( position, 1.0 );
    texCoord = uv;

}