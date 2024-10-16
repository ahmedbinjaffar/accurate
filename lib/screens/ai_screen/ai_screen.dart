import 'package:accurate/app_provider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import '../../constants/asset_images.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AiScreenState createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Acurate Scale AI",
                    style: TextStyle(
                      color: AppClr.primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: 25,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildUI(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUI() {
    return Consumer<AppProvider>(
      builder: (context, chatProvider, child) {
        return DashChat(
          currentUser: chatProvider.currentUser,
          onSend: chatProvider.sendMessage,
          messages: chatProvider.messages,
          messageOptions: MessageOptions(
            containerColor: Colors.blueAccent.shade700,
            textColor: Colors.white,
            currentUserContainerColor: AppClr.primaryColor,
            currentUserTextColor: AppClr.whiteColor,
          ),
        );
      },
    );
  }
}
