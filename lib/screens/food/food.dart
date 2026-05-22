import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:pregmaa/model/food_model.dart';
import 'package:pregmaa/data/food_data.dart';

class FoodRecommendation extends StatefulWidget {
  const FoodRecommendation({super.key});

  @override
  State<FoodRecommendation> createState() => _FoodRecommendationState();
}

class _FoodRecommendationState extends State<FoodRecommendation> {
  List<String> trimesters = ["1", "2", "3"];

  List<String> categories = [
    "Drinks",
    "Snacks",
    "Lunch",
    "Dinner",
    "Breakfast",
  ];

  String selectedTrimester = "1";
  String selectedCategory = "Drinks";
  String selectedType = "veg";

  /// 🔥 IMPORTANT
  /// First → Show all foods

  bool isFilterApplied = false;

  List<String> recentDiet = [];

  @override
  void initState() {
    super.initState();
    loadDiet();
  }

  /// LOAD RECENT DIET

  Future<void> loadDiet() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      recentDiet = prefs.getStringList('diet') ?? [];
    });
  }

  /// 🔥 FINAL FILTER LOGIC

  List<Food> get filteredFoods {
    /// FIRST LOAD → SHOW ALL

    if (!isFilterApplied) {
      return allFoods;
    }

    List<Food> result = allFoods.where((food) {
      bool matchTrimester = food.trimester == selectedTrimester;

      bool matchCategory =
          food.category.toLowerCase() == selectedCategory.toLowerCase();

      bool matchType = food.type.toLowerCase() == selectedType.toLowerCase();

      return matchTrimester && matchCategory && matchType;
    }).toList();

    /// 🔥 FALLBACK

    if (result.isEmpty) {
      return allFoods.where((food) {
        return food.trimester == selectedTrimester;
      }).toList();
    }

    return result;
  }

  /// ADD TO DIET

  Future<void> addToDiet(Food food) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> dietList = prefs.getStringList('diet') ?? [];

    dietList.insert(0, jsonEncode({"name": food.name, "image": food.image}));

    await prefs.setStringList('diet', dietList);

    loadDiet();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("${food.name} added 🍽")));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Food Recommendation"),
        backgroundColor: Colors.amber[100],
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            /// 🔥 FILTER ROW
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: Row(
                children: [
                  /// TRIMESTER
                  DropdownButton<String>(
                    value: selectedTrimester,

                    items: trimesters.map((t) {
                      return DropdownMenuItem(value: t, child: Text("T$t"));
                    }).toList(),

                    onChanged: (val) {
                      setState(() {
                        selectedTrimester = val!;

                        isFilterApplied = true;
                      });
                    },
                  ),

                  SizedBox(width: 10),

                  /// CATEGORY
                  DropdownButton<String>(
                    value: selectedCategory,

                    items: categories.map((c) {
                      return DropdownMenuItem(value: c, child: Text(c));
                    }).toList(),

                    onChanged: (val) {
                      setState(() {
                        selectedCategory = val!;

                        isFilterApplied = true;
                      });
                    },
                  ),

                  SizedBox(width: 10),

                  /// TYPE FILTER
                  ToggleButtons(
                    isSelected: [
                      selectedType == "veg",

                      selectedType == "nonveg",
                    ],

                    onPressed: (index) {
                      setState(() {
                        selectedType = index == 0 ? "veg" : "nonveg";

                        isFilterApplied = true;
                      });
                    },

                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),

                        child: Text("Veg"),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),

                        child: Text("Non-Veg"),
                      ),
                    ],
                  ),

                  SizedBox(width: 10),

                  /// RESET
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isFilterApplied = false;
                      });
                    },

                    child: Text("Reset"),
                  ),
                ],
              ),
            ),

            SizedBox(height: 15),

            /// RECENT DIET
            Text(
              "Your Recent Diet 🍽",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            SizedBox(
              height: 120,

              child: recentDiet.isEmpty
                  ? Center(child: Text("No recent diet"))
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,

                      itemCount: recentDiet.length,

                      itemBuilder: (context, index) {
                        final data = jsonDecode(recentDiet[index]);

                        return Container(
                          width: 120,

                          margin: EdgeInsets.only(right: 10),

                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),

                                child: Image.asset(
                                  data["image"],

                                  height: 80,

                                  width: 120,

                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(height: 5),

                              Text(
                                data["name"],

                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            SizedBox(height: 15),

            /// RECOMMENDED TITLE
            Text(
              "Recommended For You 💡",

              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 10),

            /// FOOD LIST
            Expanded(
              child: filteredFoods.isEmpty
                  ? Center(child: Text("No food found 😄"))
                  : ListView.builder(
                      itemCount: filteredFoods.length,

                      itemBuilder: (context, index) {
                        final food = filteredFoods[index];

                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),

                            child: Image.asset(
                              food.image,

                              width: 60,

                              height: 60,

                              fit: BoxFit.cover,
                            ),
                          ),

                          title: Text(food.name),

                          subtitle: Text(
                            "${food.category} • Trimester ${food.trimester}",
                          ),

                          trailing: IconButton(
                            icon: Icon(Icons.add),

                            onPressed: () => addToDiet(food),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
