class Event {
  final String id;
  final String name;
  final String description;
  final DateTime date;
  final String venue;
  final String category;
  final double ticketPrice;
  final List<String> images;
  final String organizer;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.date,
    required this.venue,
    required this.category,
    required this.ticketPrice,
    required this.images,
    required this.organizer,
  });
}
