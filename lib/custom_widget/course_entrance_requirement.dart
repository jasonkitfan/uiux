import 'package:flutter/material.dart';

import '../data/hd_entrance_requirement.dart';

class CourseEntranceRequirement extends StatelessWidget {
  const CourseEntranceRequirement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      margin:
          EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width) /
              8,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Entrance Requirement (Any of the following condition)",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: hdEntranceRequirement.length,
              itemBuilder: (context, index) => Column(
                    children: [
                      ListTile(
                        leading: const Text(
                          "\u2022",
                          style: TextStyle(fontSize: 30),
                        ),
                        title: Text(
                          hdEntranceRequirement[index],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      if (index != hdEntranceRequirement.length - 1)
                        const Divider(
                          color: Colors.grey,
                        )
                    ],
                  )),
          const SizedBox(height: 20),
          const Text(
            "Remark",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: remark.length,
              separatorBuilder: (ccc, iii) => const SizedBox(height: 30),
              itemBuilder: (context, index) => ListTile(
                    leading: const Text(
                      "\u2022",
                      style: TextStyle(fontSize: 30),
                    ),
                    title: Text(
                      remark.keys.elementAt(index),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                              remark[remark.keys.elementAt(index)]!.length,
                          separatorBuilder: (cc, ii) => const Divider(),
                          itemBuilder: (c, i) => remark[
                                      remark.keys.elementAt(index)]![i]
                                  .contains("=>")
                              ? Row(
                                  children: [
                                    Expanded(
                                        child: Text(remark[remark.keys
                                                .elementAt(index)]![i]
                                            .split("=>")[0])),
                                    const Expanded(
                                        child: Center(child: Text("=>"))),
                                    Expanded(
                                        child: Text(remark[remark.keys
                                                .elementAt(index)]![i]
                                            .split("=>")[1]))
                                  ],
                                )
                              : Text(remark[remark.keys.elementAt(index)]![i])),
                    ),
                  ))
        ],
      ),
    );
  }
}
