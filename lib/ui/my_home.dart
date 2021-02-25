import 'package:bloc_l2/bloc/task_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'package:bloc_l2/network/model/task_model.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BLoC Two"),
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            Expanded(child: BlocBuilder<TaskBloc, TaskState>(
              builder: (context, state) {
                if (state is TaskInitial) {
                  return Center(
                    child: Text("NO DATA COMING YET"),
                  );
                } else if (state is LoadingTaskState) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedTaskState) {
                  return _listPhotos(
                      context: context, photos: state.taskModels);
                } else if (state is FailedTaskState) {
                  // return AlertDialog(
                  //   title: Text("Network Erorr"),
                  //   content: Text(
                  //     "ကျေးဇူးပြု၍ internet ရှိမရှိ ပြန်လည်းစစ်ဆေးပေးပါ",
                  //     textAlign: TextAlign.center,
                  //   ),
                  //   actions: [
                  //     TextButton(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         child: Text('နောက်မှ')),
                  //     TextButton(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         child: Text('စစ်ဆေးပါမည်')),
                  //   ],
                  // );
                  return Center(
                    child: Text(state.error),
                  );
                }
                return null;
              },
            )),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              color: Colors.red,
              padding: EdgeInsets.symmetric(
                vertical: 15.0,
                horizontal: 40.0,
              ),
              onPressed: () {
                BlocProvider.of<TaskBloc>(context)..add(GetTaskEvent());
              },
              child: Text('Load DATA'),
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        )));
  }
}

ListView _listPhotos({BuildContext context, List<TaskModel> photos}) {
  return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              leading: Image.network(photos[index].url),
              title: Text(photos[index].title),
            ),
          ),
        );
      });
}
