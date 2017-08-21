# AsyncDisplayWeibo

AsyncDisplayKit 的node可以嵌套view来实现。我想试试不用它的layout还是用系统的frame来看看性能怎么样。。。

用了如下三种情况来测试。

1.除了富文本之外其他的都用AsyncDisplaykit。在4s下掉帧还是相当的严重的。感觉这种这样的写法太鸡肋的。

2.只是差不多包了一层asdisplaynode。用了yylabel的异步加载网络图片也是用的yyimage在4s下的掉帧不明显。

3.用uikit来实现。用了yylabel的异步加载网络图片也是用的yyimage在4s下的掉帧不明显。和2的情况基本上没大差别。

在6s下都不掉帧。。。（最好能够用自AsyncDisplaykit的layout来实现一遍看看掉帧情况，但是这个工作量太大了）


不过我发现了这篇文章 https://juejin.im/post/5987cc536fb9a03c4b374bec。。它介绍到他们开发的贝聊这个应用是用layout的方式的。我用IPAPatch hook加了个fps显示。4s上在发现页面上滑动发现掉帧还是非常明显的。

