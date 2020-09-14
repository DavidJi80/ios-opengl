precision mediump float;
uniform vec4 color;
void main(void) {
    gl_FragColor = color;
}
//现在这个uniform现在还是空的；我们还没有给它添加任何数据，这里需要注意如果你声明了一个uniform却在GLSL代码中没用过，
//编译器会静默移除这个变量，导致最后编译出的版本中并不会包含它，这可能导致几个非常麻烦的错误
