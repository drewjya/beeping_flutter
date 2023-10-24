import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:testblink/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulHookConsumerWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  late List<Key> keys;

  @override
  void initState() {
    super.initState();
    keys = List.generate(ref.read(dataProvider).length, (index) => UniqueKey());
  }

  @override
  Widget build(BuildContext context) {
    final dataVal = useState(<Data>[]);
    final dats = useState("initialData");
    useEffect(() {
      print("INIT STATE HOME");
      dats.value = "AYAM GORES";
      dataVal.value = ref.read(dataProvider);
      final timer = Timer.periodic(const Duration(milliseconds: 400), (timer) {
        ref.read(dataProvider.notifier).updateRandom();
      });
      return () {
        timer.cancel();
      };
    }, []);

    ref.listen(dataProvider, (previous, next) {
      if (dataVal.value.length != next.length) {
        final additionalKeysCount = next.length - dataVal.value.length;
        final additionalKeys =
            List.generate(additionalKeysCount, (index) => UniqueKey());

        setState(() {
          keys.addAll(additionalKeys);
        });
        dataVal.value = next;
      } else {
        dataVal.value = next;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(dats.value),
      ),
      body: ListView.builder(
        itemCount: dataVal.value.length,
        itemBuilder: (context, index) {
          return AnimatedDataItem(key: keys[index], data: dataVal.value[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TESTHIAMS(),
            ));
      }),
    );
  }
}

class AnimatedDataItem extends HookWidget {
  final Data data;

  const AnimatedDataItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(data.name),
          subtitle: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (child, animation) {
                print("$data");
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Container(
                key: ValueKey<int>(data.value),
                color: getColorForValue(data.value),
                child: Text(
                  "Value: ${data.value}",
                  style: const TextStyle(
                    color: Colors.white, // Customize the blinking color
                    fontSize: 18,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}

Color getColorForValue(int value) {
  // Define colors based on your criteria
  if (value < 20) {
    return Colors.red;
  } else if (value >= 20 && value < 50) {
    return Colors.green;
  } else {
    return Colors.blue;
  }
}

class TESTHIAMS extends StatelessWidget {
  const TESTHIAMS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
    );
  }
}
