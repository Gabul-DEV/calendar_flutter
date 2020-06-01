# calendar

A new Calendar Flutter Package

# Photo
![](https://image.prntscr.com/image/ktvtkKGBQB2A9V1vxI5RXQ.png)

# Example

```dart
Calendar(
                weekendOpacityEnable: true,
                previous: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: Offset(2.0, 0.0))
                      ]),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                      color: Colors.orange,
                    ),
                  ),
                ),
                next: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(500),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[300],
                            spreadRadius: 1.5,
                            blurRadius: 5,
                            offset: Offset(2.0, 0.0))
                      ]),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.orange,
                    ),
                  ),
                ),
                space: 20,
                onSelected: print,
                backgroundColor: Colors.white,
                activeColor: Colors.orange,
                textStyleDays: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
                textStyleWeekDay:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                titleStyle:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                selectedStyle:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
```



## Roadmap

| Feature                                   | Progress |
| :-----------------------------------------| :------: |
| Add PT-BR language                        |    ✅    |
| Add test services                         |    ✅    |
| Add test widget                           |          |
| Add test page                             |          |
| Add test controller                       |          |
| Add other languages                       |          |
| Add animations for transition             |          |
| Add differents templates                  |          |
| Add custom buidler                        |          |
| Add example genesis-tokens                |          |
