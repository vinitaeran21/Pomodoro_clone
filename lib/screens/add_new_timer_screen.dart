import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice123455/providers/pomodoro_provider.dart';
import 'package:provider/provider.dart';

import '../modelss/pomodoromodel.dart';

List<String> emojis = [
  '🍅',
  '💻',
  '☕',
  '🚿',
  '🖥️',
  '⌛',
  '🪔',
  '💤',
  '🪁',
  '✏',
  '📖',
  '🛌️',
  '🌧',
];

class AddPomodoroSheet extends StatelessWidget {
  Pomodoro editingPomodoro;
  AddPomodoroSheet({super.key, required this.editingPomodoro});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
              color: const Color(0xfff2f2f6),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Scrollbar(
                trackVisibility: true,
                child: ListView(
                  controller: controller,
                  children: [
                    EnterTitle(
                      editPomo: editingPomodoro,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TimeSelector(
                      hh: editingPomodoro.focus ~/ 60,
                      mm: editingPomodoro.focus % 60,
                      type: 'Focus',
                      colour: Colors.red,
                      editPomo: editingPomodoro,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TimeSelector(
                      hh: editingPomodoro.shortbreak ~/ 60,
                      mm: editingPomodoro.shortbreak % 60,
                      type: 'Short Break',
                      colour: Colors.green,
                      editPomo: editingPomodoro,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TimeSelector(
                      hh: editingPomodoro.longbreak ~/ 60,
                      mm: editingPomodoro.longbreak % 60,
                      type: 'Long Break',
                      colour: Colors.blue,
                      editPomo: editingPomodoro,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    LapsCounter(
                      editPomo: editingPomodoro,
                    ),
                  ],
                ),
              ),
            ));
  }
}

class LapsCounter extends StatefulWidget {
  Pomodoro editPomo;
  LapsCounter({super.key, required this.editPomo});

  @override
  State<LapsCounter> createState() => _LapsCounterState();
}

class _LapsCounterState extends State<LapsCounter> {
  @override
  Widget build(BuildContext context) {
    final PomodoroData = Provider.of<PomodoroProvider>(context);

    return Container(
      color: Colors.white,
      child: ListTile(
          contentPadding: const EdgeInsets.only(left: 16),
          leading: Text(
            'Long break after ${widget.editPomo.laps} laps',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  if (widget.editPomo.laps > 0) {
                    setState(() {
                      --widget.editPomo.laps;
                    });
                  }
                  PomodoroData.EditingPomodoro(widget.editPomo);
                },
                icon: const Icon(Icons.remove),
                visualDensity: VisualDensity.compact,
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      ++widget.editPomo.laps;
                    });
                    PomodoroData.EditingPomodoro(widget.editPomo);
                  },
                  icon: const Icon(Icons.add),
                  visualDensity: VisualDensity.compact)
            ],
          )),
    );
  }
}

class TimeSelector extends StatefulWidget {
  String type;
  Color colour;
  Pomodoro editPomo;
  int hh;
  int mm;

  TimeSelector(
      {super.key,
      required this.type,
      required this.colour,
      required this.editPomo,
      required this.hh,
      required this.mm});
  @override
  State<TimeSelector> createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  bool showNumberPicker = false;

  @override
  Widget build(BuildContext context) {
    final PomodoroData = Provider.of<PomodoroProvider>(context);

    return Container(
      color: Colors.white,
      child: Column(children: [
        ListTile(
          title: Text(
            widget.type,
            style: TextStyle(fontWeight: FontWeight.bold, color: widget.colour),
          ),
          trailing: TextButton(
            child: widget.hh == 0
                ? Text('${widget.mm} min')
                : Text('${widget.hh} hours ${widget.mm} min'),
            onPressed: () {
              setState(() {
                showNumberPicker = !showNumberPicker;
              });
            },
          ),
        ),
        if (showNumberPicker)
          CupertinoTimerPicker(
            initialTimerDuration:
                Duration(hours: widget.hh, minutes: widget.mm),
            minuteInterval: 1,
            mode: CupertinoTimerPickerMode.hm,
            onTimerDurationChanged: (change) {
              setState(() {
                widget.hh = change.inHours;
                widget.mm = change.inMinutes - change.inHours * 60;
              });
              if (widget.type == 'Focus') {
                widget.editPomo.focus = widget.hh * 60 + widget.mm;
              } else if (widget.type == 'Short Break') {
                widget.editPomo.shortbreak = widget.hh * 60 + widget.mm;
              } else if (widget.type == 'Long Break') {
                widget.editPomo.longbreak = widget.hh * 60 + widget.mm;
              }
              PomodoroData.EditingPomodoro(widget.editPomo);
            },
          )
      ]),
    );
  }
}

class EnterTitle extends StatefulWidget {
  Pomodoro editPomo;
  EnterTitle({super.key, required this.editPomo});
  @override
  State<EnterTitle> createState() => _EnterTitleState();
}

class _EnterTitleState extends State<EnterTitle> {
  bool showEmojis = false;
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title.text = widget.editPomo.title;
  }

  @override
  Widget build(BuildContext context) {
    final PomodoroData = Provider.of<PomodoroProvider>(context);

    return Column(children: [
      TextFormField(
        style: const TextStyle(fontWeight: FontWeight.bold),
        onChanged: (val) {
          widget.editPomo.title = val;
          PomodoroData.EditingPomodoro(widget.editPomo);
        },
        controller: title,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          suffixIconConstraints:
              const BoxConstraints(maxWidth: 54, maxHeight: 48),
          suffixIcon: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: const Color(0xfff2f2f6),
            ),
            margin: const EdgeInsets.only(right: 16, top: 4, bottom: 4),
            padding: EdgeInsets.zero,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    showEmojis = !showEmojis;
                  });
                },
                child: Text(
                  widget.editPomo.icon,
                  style: const TextStyle(fontSize: 20),
                )),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: showEmojis
                ? const BorderRadius.only(
                    topLeft: Radius.circular(16), topRight: Radius.circular(16))
                : BorderRadius.circular(16),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Timer title',
          hintStyle: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16),
        ),
      ),
      if (showEmojis)
        Container(
          color: Colors.white,
          height: 50,
          child: ListView.builder(
            itemCount: emojis.length,
            itemBuilder: (context, i) => TextButton(
              onPressed: () {
                widget.editPomo.icon = emojis[i];
                setState(() {
                  showEmojis = !showEmojis;
                });
                PomodoroData.EditingPomodoro(widget.editPomo);
              },
              child: Text(emojis[i], style: const TextStyle(fontSize: 24)),
            ),
            scrollDirection: Axis.horizontal,
          ),
        ),
    ]);
  }
}
