import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart'; // Import file yang dibuat

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Help Center',
          debugShowCheckedModeBanner: false,
          theme: themeProvider.currentTheme,
          home: ChatPage(),
        );
      },
    );
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  final Map<String, String> _descriptions = {
    "Bantuan untuk pasien":
        "Kami menyediakan berbagai bantuan untuk pasien, termasuk informasi tentang jadwal obat pasien",
    "Bantuan untuk tenaga kesehatan":
        "Dukungan bagi tenaga kesehatan, termasuk akses ke data pasien dan input jadwal pasien",
    "Mengenai obat dan jadwal":
        "Informasi tentang obat-obatan dan jadwal penggunaannya sesuai resep dokter yang dapat dilihat pada menu pasien.",
    "Bantuan Lainnya":
        "Jika Anda membutuhkan bantuan lain, silakan hubungi kami untuk informasi lebih lanjut.",
    "Contact developer":
        "Silakan hubungi developer di email: iqbalnur2009@gmail.com."
  };

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages
            .add({'chat': 1, 'message': "Halo, ada yang bisa saya bantu?"});
      });
    });
  }

  void _sendMessage() {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        _messages.add({'chat': 0, 'message': message});
      });
      _controller.clear();
      _botResponse(message);
    }
  }

  void _botResponse(String userMessage) {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({
          'chat': 1,
          'message': "Oke ini bantuan dari database kami",
          'options': [
            "Bantuan untuk pasien",
            "Bantuan untuk tenaga kesehatan",
            "Mengenai obat dan jadwal",
            "Bantuan Lainnya",
            "Contact developer"
          ]
        });
      });
    });
  }

  void _selectOption(String option) {
    setState(() {
      _messages.add({'chat': 0, 'message': option});
      if (_descriptions.containsKey(option)) {
        _messages.add({'chat': 1, 'message': _descriptions[option]!});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Scaffold(
      backgroundColor: isDarkMode
          ? Color(0xFF2A2A3C)
          : const Color.fromARGB(255, 37, 100, 235),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _headerChat(),
                Expanded(child: _bodyChat()),
              ],
            ),
            _inputChat(),
          ],
        ),
      ),
    );
  }

  Widget _headerChat() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context); // Kembali ke halaman sebelumnya
            },
            child:
                const Icon(Icons.arrow_back_ios, size: 25, color: Colors.white),
          ),
          const SizedBox(width: 10), // Spasi antara ikon dan teks
          const CircleAvatar(
            backgroundImage:
                AssetImage('img/avabot.png'), // Tambahkan gambar avatar
            radius: 20, // Ukuran avatar
          ),
          const SizedBox(width: 10), // Spasi antara avatar dan teks
          const Text(
            "Chatbot",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _bodyChat() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: isDarkMode ? Color.fromARGB(255, 222, 220, 220) : Colors.white,
      ),
      child: ListView.builder(
        reverse: true,
        padding: const EdgeInsets.only(bottom: 80),
        physics: const BouncingScrollPhysics(),
        itemCount: _messages.length,
        itemBuilder: (context, index) {
          final message = _messages[_messages.length - 1 - index];
          if (message.containsKey('options')) {
            return _botOptions(message['message'], message['options']);
          }
          return _chatItem(chat: message['chat'], message: message['message']);
        },
      ),
    );
  }

  Widget _botOptions(String message, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _chatItem(chat: 1, message: message),
        ...options.map((option) => _optionButton(option)).toList(),
      ],
    );
  }

  Widget _optionButton(String text) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return GestureDetector(
      onTap: () => _selectOption(text),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 50),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isDarkMode ? Color(0xFF2A2A3C) : Colors.blue.shade100,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 4,
                offset: const Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.help_outline,
                  color: isDarkMode ? Colors.white : Colors.black54, size: 15),
              const SizedBox(width: 10),
              Text(text,
                  style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatItem({required int chat, required String message}) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Row(
      mainAxisAlignment:
          chat == 1 ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (chat == 1) ...[
          const CircleAvatar(
            backgroundImage: AssetImage('img/avabot.png'),
            radius: 20,
          ),
          const SizedBox(width: 10),
        ],
        Flexible(
          child: Container(
            margin: EdgeInsets.only(
                left: chat == 1 ? 0 : 40, right: chat == 1 ? 40 : 0, top: 20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: chat == 0
                  ? isDarkMode
                      ? Color(0xFF2A2A3C)
                      : const Color.fromARGB(255, 37, 105, 255)
                  : isDarkMode
                      ? Color(0xFF2A2A3C)
                      : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(message,
                style: TextStyle(
                    color: chat == 0
                        ? Colors.white
                        : isDarkMode
                            ? Colors.white
                            : Colors.black87,
                    fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _inputChat() {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.only(top: 10), // Tambahkan sedikit jarak
        padding: const EdgeInsets.all(10),
        color: isDarkMode ? Color.fromARGB(255, 222, 220, 220) : Colors.white,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Message...",
                  filled: true,
                  fillColor:
                      isDarkMode ? Color(0xFF2A2A3C) : Colors.blue.shade100,
                  contentPadding: const EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode
                    ? Color(0xFF2A2A3C)
                    : Color.fromARGB(255, 37, 105, 255),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.all(15),
              ),
              child: const Icon(Icons.send_rounded, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
