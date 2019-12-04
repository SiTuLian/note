### CSS3过渡
  - 过渡：当知道动画的其实状态和终止状态，需要一定的变形方法时，使用过渡
  - 变形：当要在视觉上改变某个元素但又不想影响页面布局时，使用变形
  - 动画：当需要元素执行一些列关键帧动画时，使用CSS动画

  #### CSS过渡的使用
    transition: all 1s ease 0s  
      过渡的属性名（如背景，宽度） | 时长 | 过渡期间的速度变化 | 过渡开始前的延迟时间
    all 是全部 如果只有透明度，要设置成opacity，不然会加重浏览器的负载

  ##### 可以同时过渡多个属性
    ```css
      .style{
        transition-property: border, color, text-shadow;
        transition-duration: 2s, 3s, 8s;
      }
    ```

  ##### 过渡函数
    - ease
    - linear
    - ease-in
    - ease-in-out
    - cubic-bezier

### CSS 2D变形  transform
  - scale 缩放元素
  - translate 移动元素
  - rotate 按照一定角度旋转元素，单位为度。
  - skew 沿X和Y轴切斜   skew(40deg, 12deg)
  - matrix 允许以像素精度来控制变形结果   矩阵变形   www.usergentman.com/matrix  生成相关代码
  - transform-origin 修改变形原点，默认为元素中心 
    transform-origin: 270px 20px | 水平偏移 | 纵向偏移

### CSS 3D变形
  - transform-origin x轴 y轴 z轴  中心点的位置
  - transform--style preserve-3d	表示所有子元素在3D空间中呈现。
  - perspective number  定义在父元素 元素离屏幕的距离
  - perspective-origin  定义在父元素 改变 3D 元素的底部位置。
  - backface-visibility 定义当元素不面向屏幕时是否可见。

### CSS 动画

  - @keyframe 定义关键帧规则
  - animation 关键帧规则名 动画时长 动画开始延迟 动画运行次数,infinite（无限次） 动画播放方向(alternate 交替，来回播放)
  - animation-fill-mode: forwards 保留动画结束的值

