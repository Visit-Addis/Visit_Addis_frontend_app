import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/events_provider.dart';
import '../../domain/models/event.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final eventId = ModalRoute.of(context)?.settings.arguments as String?;
      if (eventId != null) {
        context.read<EventsProvider>().fetchEventById(eventId, context);
      }
    });
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
        actions: [
          Consumer<EventsProvider>(
            builder: (context, provider, child) {
              final event = provider.selectedEvent;
              if (event == null) return const SizedBox.shrink();
              
              return IconButton(
                icon: Icon(
                  event.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
                onPressed: () => provider.toggleBookmark(event.id, context),
              );
            },
          ),
        ],
      ),
      body: Consumer<EventsProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      final eventId = ModalRoute.of(context)?.settings.arguments as String?;
                      if (eventId != null) {
                        provider.fetchEventById(eventId, context);
                      }
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final event = provider.selectedEvent;
          if (event == null) {
            return const Center(child: Text('Event not found'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      event.imageUrl,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(Icons.error),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _InfoChip(
                        icon: Icons.attach_money,
                        label: '${event.entryFee} ETB',
                      ),
                      const SizedBox(width: 8),
                      _InfoChip(
                        icon: Icons.people,
                        label: '${event.capacity} people',
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    event.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.venue,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.date.toString(),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    event.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (event.galleryImages.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(
                      'Gallery',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: event.galleryImages.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                event.galleryImages[index],
                                width: 200,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 200,
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Contact Information',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text('Phone'),
                    subtitle: Text(event.organizerContact),
                    onTap: () => _launchUrl('tel:${event.organizerContact}'),
                  ),
                  if (event.website != null) ...[
                    ListTile(
                      leading: const Icon(Icons.web),
                      title: const Text('Website'),
                      subtitle: Text(event.website!),
                      onTap: () => _launchUrl(event.website!),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
    );
  }
} 