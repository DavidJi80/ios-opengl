precision mediump float;
varying lowp vec4 aColor;

void main(void) {
    gl_FragColor = aColor;
}
// aColor 接受顶点着色器输出的颜色
// 设置最终颜色为接受的颜色
