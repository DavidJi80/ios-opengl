attribute vec4 Position;
attribute vec4 color;
varying vec4 aColor;

void main(void) {
    gl_Position = Position;
    aColor = color;
}
// aColor 向片段着色器输出一个颜色
// aColor设置为我们从顶点数据那里得到的输入颜色
