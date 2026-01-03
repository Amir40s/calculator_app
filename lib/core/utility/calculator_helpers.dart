import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../../config/model/conversion_calculator/all_calculator_model.dart';
import '../../config/res/app_assets.dart';

class CalculatorHelpers {
  // Helper method to get icon for calculator based on title/keywords
  static IconData getIconForCalculator(CalculatorModel calc) {
    final title = calc.title.toLowerCase();
    final routeKey = calc.routeKey.toLowerCase();

    if (title.contains('concrete') || routeKey.contains('concrete')) {
      return LucideIcons.building2;
    } else if (title.contains('formwork') || routeKey.contains('formwork')) {
      return LucideIcons.layers;
    } else if (title.contains('stair') || routeKey.contains('stair')) {
      return LucideIcons.trendingUp;
    } else if (title.contains('column') || routeKey.contains('column')) {
      return LucideIcons.columns3;
    } else if (title.contains('beam') || routeKey.contains('beam')) {
      return LucideIcons.minus;
    } else if (title.contains('slab') || routeKey.contains('slab')) {
      return LucideIcons.square;
    } else if (title.contains('excavation') || routeKey.contains('excavation')) {
      return LucideIcons.shovel;
    } else if (title.contains('plaster') || routeKey.contains('plaster')) {
      return LucideIcons.paintbrush;
    } else if (title.contains('block') || routeKey.contains('block')) {
      return LucideIcons.box;
    } else if (title.contains('door') || routeKey.contains('door')) {
      return LucideIcons.doorOpen;
    } else if (title.contains('window') || routeKey.contains('window')) {
      return LucideIcons.square;
    } else if (title.contains('paint') || routeKey.contains('paint')) {
      return LucideIcons.palette;
    } else if (title.contains('cost') || routeKey.contains('cost')) {
      return LucideIcons.dollarSign;
    } else if (title.contains('pump') || routeKey.contains('pump')) {
      return LucideIcons.droplet;
    } else if (title.contains('water') || routeKey.contains('water')) {
      return LucideIcons.droplets;
    } else if (title.contains('conversion') || routeKey.contains('conversion')) {
      return LucideIcons.refreshCw;
    } else if (title.contains('marble & granite') || routeKey.contains('conversion')) {
      return LucideIcons.inspectionPanel;}
    else if (title.contains('earth work') || routeKey.contains('earth')) {
      return LucideIcons.inspectionPanel; }

    else if (title.contains('driveway & pathway') || routeKey.contains('driveway & pathway')) {
      return LucideIcons.car;
    }

    else if (title.contains('flooring & grouting') || routeKey.contains('flooring & grouting')) {
      return LucideIcons.layers; }

    else if (title.contains('electrical wiring') || routeKey.contains('electrical wiring')) {
      return LucideIcons.zap;}

    else if (title.contains('finishing & interior') || routeKey.contains('interior')) {
      return LucideIcons.paintBucket;
    } else {
      return LucideIcons.calculator;
    }
  }

  // Helper method to get image for calculator
  static String getImageForCalculator(CalculatorModel calc) {
    final title = calc.title.toLowerCase();
    final routeKey = calc.routeKey.toLowerCase();

    if (title.contains('concrete') || routeKey.contains('concrete')) {
      return AppAssets.concreteGen;
    } else if (title.contains('formwork') || routeKey.contains('formwork')) {
      return AppAssets.concreteFormworkCategory;
    } else if (title.contains('stair') || routeKey.contains('stair')) {
      return AppAssets.concreteGen;
    } else if (title.contains('column') || routeKey.contains('column')) {
      return AppAssets.concreteGen;
    } else if (title.contains('beam') || routeKey.contains('beam')) {
      return AppAssets.concreteGen;
    } else if (title.contains('slab') || routeKey.contains('slab')) {
      return AppAssets.concreteGen;
    } else if (title.contains('excavation') || routeKey.contains('excavation')) {
      return AppAssets.earthworkGen;
    } else if (title.contains('plaster') || routeKey.contains('plaster')) {
      return AppAssets.wallRoofPlaster;
    } else if (title.contains('block') || routeKey.contains('block')) {
      return AppAssets.wallBlock;
    } else if (title.contains('door') || routeKey.contains('door')) {
      return AppAssets.doorsGen;
    } else if (title.contains('window') || routeKey.contains('window')) {
      return AppAssets.doorsWindowsCategory;
    } else if (title.contains('paint') || routeKey.contains('paint')) {
      return AppAssets.finishingGen;
    } else if (title.contains('cost') || routeKey.contains('cost')) {
      return AppAssets.categoryCost;
    } else if (title.contains('pump') || routeKey.contains('pump')) {
      return AppAssets.waterpump;
    } else if (title.contains('water') || routeKey.contains('water')) {
      return AppAssets.waterpump;
    } else if (title.contains('conversion') || routeKey.contains('conversion')) {
      return AppAssets.categoryConversion;
  } else if (title.contains('marble & granite') || routeKey.contains('conversion')) {
      return AppAssets.marbleGen;
    }
    else if (title.contains('earth work') || routeKey.contains('earth')) {
      return AppAssets.earthworkGen;}
    else if (title.contains('driveway & pathway') || routeKey.contains('driveway & pathway')) {
      return AppAssets.drivewayGen;
    }
    else if (title.contains('flooring & grouting') || routeKey.contains('flooring & grouting')) {
      return AppAssets.tileBondInstallation; }
    else if (title.contains('electrical wiring') || routeKey.contains('electrical wiring')) {
      return AppAssets.mep; }
    else if (title.contains('finishing & interior') || routeKey.contains('interior')) {
      return AppAssets.finishingInteriorCategory;
    } else {
      return AppAssets.splash;
    }
  }

  // Helper method to get color for calculator
  static Color getColorForCalculator(CalculatorModel calc, int index) {
    final title = calc.title.toLowerCase();
    final routeKey = calc.routeKey.toLowerCase();

    if (title.contains('concrete') || routeKey.contains('concrete')) {
      return const Color(0xFF00BCD4);
    } else if (title.contains('formwork') || routeKey.contains('formwork')) {
      return const Color(0xFF4CAF50);
    } else if (title.contains('stair') || routeKey.contains('stair')) {
      return const Color(0xFF9C27B0);
    } else if (title.contains('column') || routeKey.contains('column')) {
      return const Color(0xFF2196F3);
    } else if (title.contains('beam') || routeKey.contains('beam')) {
      return const Color(0xFF00ACC1);
    } else if (title.contains('slab') || routeKey.contains('slab')) {
      return const Color(0xFF795548);
    } else if (title.contains('excavation') || routeKey.contains('excavation')) {
      return const Color(0xFF8D6E63);
    } else if (title.contains('plaster') || routeKey.contains('plaster')) {
      return const Color(0xFFFF9800);
    } else if (title.contains('block') || routeKey.contains('block')) {
      return const Color(0xFF607D8B);
    } else if (title.contains('door') || routeKey.contains('door')) {
      return const Color(0xFF3F51B5);
    } else if (title.contains('window') || routeKey.contains('window')) {
      return const Color(0xFF03A9F4);
    } else if (title.contains('paint') || routeKey.contains('paint')) {
      return const Color(0xFFE91E63);
    } else if (title.contains('cost') || routeKey.contains('cost')) {
      return const Color(0xFF4CAF50);
    } else if (title.contains('pump') || routeKey.contains('pump')) {
      return const Color(0xFF00BCD4);
    } else if (title.contains('water') || routeKey.contains('water')) {
      return const Color(0xFF2196F3);
    } else if (title.contains('conversion') || routeKey.contains('conversion')) {
      return const Color(0xFF9E9E9E);
  } else if (title.contains('marble & granite') || routeKey.contains('conversion')) {
      return const Color(0xFF64748B);
    }
    else if (title.contains('driveway & pathway') || routeKey.contains('driveway & pathway')) {
      return const Color(0xFF6B7280);}
    else if (title.contains('earth work') || routeKey.contains('earth')) {
      return const Color(0xFFD97706);}
    else if (title.contains('flooring & grouting') || routeKey.contains('flooring & grouting')) {
      return const Color(0xFF6366F1);}
    else if (title.contains('electrical wiring') || routeKey.contains('electrical wiring')) {
      return const Color(0xFFEAB308);}
    else if (title.contains('finishing & interior') || routeKey.contains('interior')) {
      return const Color(0xFFA855F7);
    } else {
      final colors = [
        const Color(0xFFE91E63),
        const Color(0xFF9C27B0),
        const Color(0xFF673AB7),
        const Color(0xFF3F51B5),
        const Color(0xFF2196F3),
        const Color(0xFF00BCD4),
      ];
      return colors[index % colors.length];
    }
  }
}

