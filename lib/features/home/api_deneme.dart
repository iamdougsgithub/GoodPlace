import 'package:flutter/material.dart';
import 'package:good_place/features/home/quotable_api_service.dart';
import 'package:good_place/features/home/quote_model.dart';

// Bu widget silinecek
// Bu widget quote api servisinden dönen random değeri görmek için konmuştur

void main() {
  runApp(MyQuote());
}

class MyQuote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Quote'),
        ),
        body: Center(
          child: QuoteWidget(),
        ),
      ),
    );
  }
}

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({super.key});

  @override
  QuoteWidgetState createState() => QuoteWidgetState();
}

class QuoteWidgetState extends State<QuoteWidget> {
  late Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    futureQuote = ApiService().getRandomQuote(); // random alıntı yı al.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Quote>(
      future: futureQuote,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        // Bir veri geldiyse onu istediğin gibi kullan
        else if (snapshot.hasData) {
          final quote = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '"${quote.content}"', // bizim kullanacağımız değer
                style:
                    const TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                '- ${quote.author}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
