# StrydDataVisualization

Demo of app:

![alt text] (https://github.com/ryujimano/StrydDataVisualization/blob/master/StrydDataDemo.gif)

Line graph initially shows both heart rate and power data. The heart rate data is shown in red, and the power data is shown in blue.
The power and heart rate buttons each turns its respective lines on/off. To view the graph in larger scale, tap on the graph, and a new zoomable view will show modally.

Some Issues:
- The range of the power data is relatively high, so line drawing is fairly slow. This should be fixed so it can render faster in the future (e.g. stop redrawing the view to make it faster).
- The initial value in both data have a random spike that needs to be fixed.
- The ScrollView fixes its height, making zooming slightly difficult.
