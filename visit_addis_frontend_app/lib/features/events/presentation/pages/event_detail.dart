import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/events_model.dart';
import '../bloc/event_bloc.dart';

class EventDetailScreen extends StatefulWidget {
  final String eventId;

  const EventDetailScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  Event? _event;

  @override
  void initState() {
    super.initState();
    _fetchEventDetails();
  }

  Future<void> _fetchEventDetails() async {
    try {
      final event = await context
          .read<EventCubit>()
          .apiService
          .fetchEventById(widget.eventId);
      setState(() {
        _event = event;
      });
    } catch (e) {
      print('Error fetching event details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_event == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    bool isFavorite = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _event!.name ?? 'No Name',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  if (_event!.images != null && _event!.images!.isNotEmpty)
                    Image.network(
                      _event!.images!.first.url,
                      fit: BoxFit.cover,
                      height: 250,
                      width: double.infinity,
                    )
                  else
                    Container(
                      height: 250,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Center(child: Text('No Image Available')),
                    ),
                  Positioned(
                    left: 10,
                    top: 10,
                    child: _iconButton(Icons.arrow_back_ios_new, () {
                      Navigator.pop(context);
                    }),
                  ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: _iconButton(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      color: isFavorite ? Colors.pinkAccent : Colors.white,
                    ),
                  ),
                  Positioned(
                    right: 60,
                    top: 10,
                    child: _iconButton(Icons.download, () {
                      print('Download clicked');
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _event!.name ?? 'No Name',
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.calendar_today),
                  const SizedBox(width: 5),
                  Text("${_event!.date ?? ''}, ${_event!.time ?? ''}"),
                ],
              ),
              const SizedBox(height: 20),
              const Text("About",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              const SizedBox(height: 10),
              Text(_event!.description ?? 'No Description'),
              const SizedBox(height: 30),
              if (_event!.averageRating != null)
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber),
                    Text("${_event!.averageRating} / 5"),
                  ],
                ),
              const SizedBox(height: 10),
              if (_event!.reviews != null && _event!.reviews!.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Reviews",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    ..._event!.reviews!.map(
                      (review) => ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(review.comment ?? 'No comment'),
                        subtitle: Text("Rating: ${review.rating}"),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onPressed, {Color color = Colors.white}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 3),
        borderRadius: BorderRadius.circular(8),
        color: Colors.greenAccent,
      ),
      child: IconButton(
        icon: Icon(icon, size: 20, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
