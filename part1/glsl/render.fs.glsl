//Q1d implement the whole thing to map the depth texture to a quad
// TODO:
uniform sampler2D tDiffuse;
uniform sampler2D tDepth;
in vec4 screenPos;

void main() {
    gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
    gl_FragColor = texture(tDepth, screenPos.xy);
}