### flex布局

  #### 将固定的像素大小转换为弹性比例大小

    公式：结果 = 目标/上下文 即 元素大小除以元素所在的容器

  #### 弹性布局可以做到什么
    - 方便垂直居中内容
    - 改变元素的视觉次序
    - 在盒子里自动插入空白及其对其元素，自动对其元素间的空白

  #### 垂直居中显示
    ```css
      .class{
        display: flex;
        justify-content: center;
        align-items: center;
      }
    ```
  #### 偏移
    ```css
      .class{
        display: flex;
        align-items: center;
      }
    ```
  #### 反序
    ```css
      .class{
        display: flex;
        justify-content: center;
        align-items: center;
           /* 添加 */
        flex-direction: row-reverse;
      }
    ```
  #### 垂直排列
    ```css
      .class{
        display: flex;
        justify-content: center;
        align-items: center;
        /* 添加 */
        flex-direction: column;
      }
    ```
  #### 垂直反序
    ```css
    .class{
        display: flex;
        justify-content: center;
        align-items: center;
        /* 添加 */
        flex-direction: column-reverse;
      }
    ```
  #### inline-flex
    inline-flex 行内块元素的变种，如果父元素不设置flex，在子元素设置inline-flex，父元素会被一起带动

  #### flex布局的对齐
    flex有主轴和交叉轴，
    当flex方向为row，时主轴为横轴，交叉轴是纵轴
    当flex方向为column，主轴为纵轴，交叉轴为横轴
    
    justify-content: flex-start | center | flex-end | space-between | space-around
      在方向为row的情况下，其值分别是左边，中间，右边，左右对齐，间隔对齐
    align-items: flex-start | center | flex-end | baseline | stretch
      在方向为row的情况下，其值分别是左边，中间，右边，沿基线对齐，所有项拉伸至与父元素一样大
    
    这些都是在父元素上设置的，子元素会统一按照其规则排列，如果某个子元素要用特别的排列，请用align-self
    align-self:  flex-start | center | flex-end

  #### flex 定义 伸缩性
    flex 是 三个属性的简写
      - flex-grow 在空间剩余时伸展的量
      - flex-shrink 在空间不足时收缩的量
      - flex-basis 不伸缩时的大小
    
    flex 1 1 100px -> 伸展 收缩 基准
    
    flex 写在子标签里

  #### order
    order -> 修改次序
    order: -1

  #### flex-flow 
    flex-flow 属性是 flex-direction 和 flex-wrap 属性的复合属性。
      - flex-direction  决定主轴的方向，row,column
      - flex-wrap 控制flex容器是单行或者多行，同时横轴的方向决定了新行堆叠的方向。
        + wrap  折行
        + wrap-reverse  反序折行

