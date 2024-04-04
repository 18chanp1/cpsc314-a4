//Q1d implement the whole thing to map the depth texture to a quad
// TODO:
uniform sampler2D tDiffuse;
uniform sampler2D tDepth;
in vec4 screenPos;
in vec2 texCoord;

void main() {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);

    //map depth texture to quad
    float depth = texture2D(tDepth, texCoord).x;
    gl_FragColor = vec4(vec3(depth), 1.0);
    
    
}