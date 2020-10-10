//
//  GLSL1ViewController.m
//  ios-opengl
//
//  Created by mac on 2020/9/8.
//  Copyright © 2020 TongArk. All rights reserved.
//

#import "GLSL1ViewController.h"

@interface GLSL1ViewController (){
    GLuint program;
}

@property (assign, nonatomic) GLfloat changeValue;
@property (strong, nonatomic) EAGLContext *glContext;

@end

@implementation GLSL1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupGLContext];
    
    [self compileShaders];
}

// 配置OpenGL和GLKit
- (void)setupGLContext {
    self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    [EAGLContext setCurrentContext:self.glContext];
    
    self.preferredFramesPerSecond = 60;
    GLKView *view = (GLKView *)self.view;
    view.context = self.glContext;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    view.drawableMultisample = GLKViewDrawableMultisample4X;
}

- (void)compileShaders {
    // 生成一个顶点着色器对象
    GLuint vertexShader = [self compileShader:@"VertexShader" withType:GL_VERTEX_SHADER];
    
    // 生成一个片段着色器对象
    GLuint fragmentShader = [self compileShader:@"fragmentShader" withType:GL_FRAGMENT_SHADER];
    
    /*
     调用了glCreateProgram glAttachShader  glLinkProgram 连接 vertex 和 fragment shader成一个完整的program。
     着色器程序对象(Shader Program Object)是多个着色器合并之后并最终链接完成的版本。
     如果要使用刚才编译的着色器我们必须把它们链接(Link)为一个着色器程序对象，
     然后在渲染对象的时候激活这个着色器程序。已激活着色器程序的着色器将在我们发送渲染调用的时候被使用。
     */
    program = glCreateProgram();  // 创建一个程序对象
    glAttachShader(program, vertexShader); // 链接顶点着色器
    glAttachShader(program, fragmentShader); // 链接片段着色器
    glLinkProgram(program); // 链接程序
    
    // 把着色器对象链接到程序对象以后，记得删除着色器对象，我们不再需要它们了
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    
    // 调用 glGetProgramiv来检查是否有error，并输出信息。
    GLint linkSuccess;
    glGetProgramiv(program, GL_LINK_STATUS, &linkSuccess);
    if (linkSuccess == GL_FALSE) {
        GLchar messages[256];
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"着色器程序:%@", messageString);
        exit(1);
    }
}

- (GLuint)compileShader:(NSString *)shaderName withType:(GLenum)shaderType {
    // NSBundle中加载文件
    NSString *shaderPath = [[NSBundle mainBundle] pathForResource:shaderName ofType:@"glsl"];
    
    NSError* error;
    NSString* shaderString = [NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:&error];
    
    // 如果为空就打印错误并退出
    if (!shaderString) {
        NSLog(@"Error loading shader: %@", error.localizedDescription);
        exit(1);
    }
    
    // 使用glCreateShader函数可以创建指定类型的着色器对象。shaderType是指定创建的着色器类型
    GLuint shader = glCreateShader(shaderType);
    
    // 这里把NSString转换成C-string
    const char* shaderStringUTF8 = [shaderString UTF8String];
    
    int shaderStringLength = (int)shaderString.length;
    
    // 使用glShaderSource将着色器源码加载到上面生成的着色器对象上
    glShaderSource(shader, 1, &shaderStringUTF8, &shaderStringLength);
    
    // 调用glCompileShader 在运行时编译shader
    glCompileShader(shader);
    
    // glGetShaderiv检查编译错误（然后退出）
    GLint compileSuccess;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &compileSuccess);
    if (compileSuccess == GL_FALSE) {
        GLchar messages[256];
        NSString *messageString = [NSString stringWithUTF8String:messages];
        NSLog(@"生成着色器对象:%@", messageString);
        exit(1);
    }
    
    // 返回一个着色器对象
    return shader;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    // 清空之前的绘制
    glClearColor(1.0, 1.0, 1.0, 1);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glUseProgram(program);
    
    [self drawGraphics];
    
    [self update];
}

- (void)drawGraphics {
    static GLfloat triangleData[18] = {
        
        // 位置           // 颜色
        0.0,   0.5f,  0,  1,  0,  0,
       -0.5f, -0.5f,  0,  0,  1,  0,
        0.5f, -0.5f,  0,  0,  0,  1,
    };
    

    GLuint positionLoca = glGetAttribLocation(program, "position");
    glEnableVertexAttribArray(positionLoca);
    
    GLuint colorLoca = glGetAttribLocation(program, "color");
    glEnableVertexAttribArray(colorLoca);
    
    GLuint variableLoca = glGetUniformLocation(program, "variable");
    glUniform1f(variableLoca, (GLfloat)self.changeValue);
    
    glVertexAttribPointer(positionLoca, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (char *)triangleData);
    glVertexAttribPointer(colorLoca, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (char *)triangleData + 3 * sizeof(GLfloat));
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

- (void)update {
    NSTimeInterval time = self.timeSinceLastUpdate;
    self.changeValue += time;
}

@end
