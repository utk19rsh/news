import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:news/components/backend/functions.dart';
import 'package:news/components/backend/showEmailProvider.dart';
import 'package:news/components/model/postModel.dart';
import 'package:news/constants.dart';
import 'package:news/screens/home/components.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    if (mounted) {
      Provider.of<ShowEmail>(context, listen: false).inception();
    }
    super.initState();
  }

  Future<List<Post>> inception() async {
    List<Post> posts = [];
    final http.Response res = await http.get(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/comments',
      ),
    );
    List<dynamic> body = jsonDecode(res.body) as List<dynamic>;
    if (res.statusCode == 200) {
      for (int i = 0; i < body.length; i++) {
        dynamic json = body[i];
        Map<String, dynamic> details = json as Map<String, dynamic>;
        posts.add(
          Post.fromJson(
            id: details["id"],
            postId: details["postId"],
            email: details["email"],
            body: details["body"],
            name: details["name"],
          ),
        );
      }
    }
    return posts;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: RefreshIndicator(
        onRefresh: () => pushReplacement(
          context,
          ChangeNotifierProvider(
            create: (context) => ShowEmail(),
            child: const Home(),
          ),
        ),
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        backgroundColor: theme,
        color: white,
        displacement: 50,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: theme,
            title: const Text("Comments", style: TextStyle(color: white)),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: theme,
              statusBarIconBrightness: Brightness.light,
            ),
            actions: [SignoutIcon(mounted: mounted)],
          ),
          body: SizedBox.expand(
            child: FutureBuilder<List<Post>>(
              future: inception(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Post> posts = snapshot.data!;
                  return ListView.builder(
                    controller: controller,
                    shrinkWrap: true,
                    itemCount: posts.length,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                    itemBuilder: (context, index) {
                      Post post = posts[index];
                      return PostTile(
                        name: post.name,
                        email: post.email,
                        body: post.body,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
