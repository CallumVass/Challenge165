import "dart:async";
import "dart:math";

class Forest {
  num size;
  num age = 0;
  Timer timer;
  ForestAge forestAge;
  List<Point> forestGrid = new List<Point>();

  Forest(this.size);

  void start() {
    print("forest started");
    createForest();
    const oneSec = const Duration(milliseconds:1);
    timer = new Timer.periodic(oneSec, (Timer t) => nextEvent());
  }

  createForest() {
    for(int y = 0; y < size; y++){
      for(int x = 0; x < size; x++) {
        forestGrid.add(new Point(x, y));
      }
    }

    forestGrid.forEach((x) => print("X: ${x.x}, Y: ${x.y}"));
  }

  nextEvent() {
    age++;
    if(age >= 4800) {
      timer.cancel();
    }

    forestAge = new ForestAge(age);
    //print(forestAge.totalMonths);
    //print(forestAge.totalYears);
  }
}

class ForestAge {
  num age;

  ForestAge(this.age);

  get totalYears => (age / 12).round();
  get totalMonths => age;
}

void main() {
  scheduleMicrotask(new Forest(10).start);
}