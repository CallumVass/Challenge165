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
          plot.lumberjack = new Lumberjack();
        }

        if (randomNumber < maxTrees && currentTrees < maxTrees) {
          plot.tree = new Tree();
        }

        if (randomNumber < maxBears && currentBears < maxBears) {
          plot.bear = new Bear();
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

    plots.forEach((x) => forestCycle(x));
    plots.where((x) => x.point.x == 9 && x.point.y == 9).forEach((x) => print("Age: ${forestAge.totalMonths}, Tree: ${x.tree}"));
  }

  forestCycle(ForestPlot forestPlot) {
    if(forestPlot.tree != null) {
      forestPlot.tree = forestPlot.tree.upgrade();
    }
  }
}

class ForestPlot {
  Point point;
  Bear bear;
  ForestTree tree;
  Lumberjack lumberjack;

  ForestPlot(this.point);
}

class ForestAge {
  num _age;

  ForestAge(this._age);

  get totalYears => (_age / 12).round();

  get totalMonths => _age;
}

abstract class ForestTree {
  ForestTree upgrade();
}

class Sapling extends ForestTree {

  ForestTree upgrade() {
    return new Tree();
  }
}

class Tree extends ForestTree {

  ForestTree upgrade() {
    return new ElderTree();
  }
}

class ElderTree extends ForestTree {

  ForestTree upgrade() {
    return this;
  }
}

class Lumberjack {

}

class Bear {

}

void main() {
  scheduleMicrotask(new Forest(10).start);
}