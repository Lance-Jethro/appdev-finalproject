import 'package:flutter/material.dart';

class Homebody extends StatelessWidget {
  const Homebody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width * .98,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * .02),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Eat Fresh Pizza",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    "Our daily fresh pizzas",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black45,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.50,
            width: MediaQuery.of(context).size.width * .88,
            margin: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width * .025,
              0,
              MediaQuery.of(context).size.width * .025,
              0,
            ),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/pizza_1.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 0.415,
                  height: MediaQuery.of(context).size.height * 0.50,
                  margin: EdgeInsets.only(
                      right: MediaQuery.of(context).size.width * 0.05),
                ),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/images/pizza_2.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.415,
                      height: MediaQuery.of(context).size.height * 0.235,
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * .025),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        image: DecorationImage(
                          image: AssetImage("assets/images/pizza_3.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width * 0.415,
                      height: MediaQuery.of(context).size.height * 0.24,
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * .90,
            height: MediaQuery.of(context).size.height * 0.25,
            margin: EdgeInsets.all(MediaQuery.of(context).size.width * .06),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/pizza_4.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.49,
                  margin: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.05,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/pizza_5.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.34,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
