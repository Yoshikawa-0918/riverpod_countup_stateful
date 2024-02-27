import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_countup_stateful/provider.dart';

void main() {
  runApp(
    //ProviderScope: 子要素内でProviderを使えるようにする
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  //WidgetRef: Riverpod内のProviderにアクセスすることができる
  @override
  Widget build(BuildContext context) {
    print("MyHomePage rebuild");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        //ConsumerでWrapしてProviderを参照できるようにする
        title: Text(
          //titleProviderの値を監視して、値を表示
          ref.watch(titleProvider),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(
              builder: (context, ref, child) => Text(
                //countProviderの値を参照する
                ref.watch(countProvider).toString(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Text(
              //messageProviderの値を監視して、値を表示
              ref.watch(messageProvider),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //countProviderの値をonPressed内で更新する際はref.readを使用する(Buttonを押した時に、Buttonも一緒にリビルドされてしまう)
        onPressed: () => ref.read(countProvider.notifier).state++,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
