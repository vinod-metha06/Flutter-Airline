import 'package:flutter/material.dart';
import 'package:airlines/api/service.dart';
import 'package:provider/provider.dart';
import '../provider/res.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _service = Api();
  void initState() {
    super.initState();
    // _service.getAll();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Counter>(context, listen: false).getAllPhotos();
    });
  }

  @override
  Widget build(BuildContext context) {
    //  var list = context.watch<Counter>().getAllPhotos();
    var item = context.watch<Counter>().photos;
    print(item);
    TextEditingController controller = TextEditingController();
    print(context.watch<Counter>().al.title);

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.purple,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(2),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(),
              child: TextField(
                  controller: controller,
                  onChanged: ((value) =>
                      context.read<Counter>().getAl(controller.text)),
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)))),
            ),
            Text(context.watch<Counter>().al.title == null
                ? ""
                : context.watch<Counter>().al.id.toString()),
            context.watch<Counter>().al.title != null
                ? Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(4),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Image.network(context.watch<Counter>().al.url),
                        Text("Id: ${context.watch<Counter>().al.id}"),
                        Text("Title: ${context.watch<Counter>().al.title}")
                      ],
                    ),
                  )
                : Text(""),
            Expanded(
              child: Consumer<Counter>(
                builder: (context, value, child) {
                  if (value.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final todos = value.photos;
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      return Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: ListTile(
                          leading: CircleAvatar(
                            maxRadius: 40,
                            child: Image.network(todo.url),
                          ),
                          title: Text(
                            todo.title.toString().substring(0, 10) + "...",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ));
  }
}
