
####
[Here](https://github.com/jamztang/CSStickyHeaderFlowLayout) is a better implemetation.  

## Why Use It

* It helps you create a tableview(scrollview) with parallax effect, much like the top view of Path's timeline, by a easier way.

![](https://raw.github.com/demon1105/ImagesLib/master/demo_parallaxview.gif)
##What did i do

* It's just a instance method of UIScrollView's category, so we can add the parallax effect naturally.

## How To Use

```
//we get a tableView here, of course, any kind of UIScrollView class's object is fine.
UITableView* tableView = [self createTableView];
//get a parallax background view.
UIView * parallaxView = [self getParallaxView];
//that's all.
[tableView addForegroundView:[self getParallaxView]
            withWindowHeight:100
           dragDistanceLimit:0
              parallaxFactor:0.25];

```

##Creator
[Nicholas Tau](http://www.taofengping.com)

## License

NTParallaxView is available under the MIT license. See the LICENSE file for more info.


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/demon1105/ntparallaxview/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

