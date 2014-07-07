import "dart:async";
import "dart:math";

class Forest {
  num size;
  num age = 0;
  num maxLumberjacks;
  num maxTrees;
  num maxBears;
  Timer timer;
  ForestAge forestAge;
  List<ForestPlot> plots = new List<ForestPlot>();

  Forest(this.size) {
    var plotSpaces = size * size;
    maxLumberjacks = plotSpaces * 0.1;
    maxTrees = plotSpaces * 0.5;
    maxBears = plotSpaces * 0.02;
  }

  void start() {
    print("forest started");
    createForest();
  }

  createForest() {
    for (int y = 0; y < size; y++) {
      for (int x = 0; x < size; x++) {
        var plot = new ForestPlot(new Point(x, y));
        var currentBears = plots.where((b) => b.bear != null).length;
        var currentTrees = plots.where((t) => t.tree != null).length;
        var currentLumberjacks = plots.where((l) => l.lumberjack != null).length;
        var randomNumber = new Random().nextInt(100);

        if (randomNumber < maxLumberjacks && currentLumberjacks < maxLumberjacks) {
          plot.addLumberjack(new Lumberjack());
        }

        if (randomNumber < maxTrees && currentTrees < maxTrees) {
          plot.addTree(new Tree());
        }

        if (randomNumber < maxBears && currentBears < maxBears) {
          plot.addBear(new Bear());
        }

        plots.add(plot);
      }
    }

    const oneSec = const Duration(milliseconds:1);
    timer = new Timer.periodic(oneSec, (Timer t) => nextEvent());
  }

  nextEvent() {
    age++;
    if (age >= 4800) {
      timer.cancel();
    }
    forestAge = new ForestAge(age);

    //plots.where((x) => x.point.x == 9 && x.point.y == 9).forEach((x) => print("Tree: ${x.tree}"));
  }
}

class ForestPlot {
  Point point;
  Bear bear;
  ForestTree tree;
  Lumberjack lumberjack;

  ForestPlot(this.point);

  void addBear(Bear bear) {
    this.bear = bear;
  }

  void addTree(ForestTree tree) {
    this.tree = tree;
  }

  void addLumberjack(Lumberjack lumberjack) {
    this.lumberjack = lumberjack;
  }
}

class ForestAge {
  num age;

  ForestAge(this.age);

  get totalYears => (age / 12).round();

  get totalMonths => age;
}

abstract class ForestTree {

}

class Tree extends ForestTree {

}

class Sapling extends ForestTree {

}

class ElderTree extends ForestTree {

}

class Lumberjack {

}

class Bear {

}

void main() {
  scheduleMicrotask(new Forest(10).start);
}