import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/events_provider.dart';
import '../widgets/event_card.dart';
import '../widgets/event_filter_bar.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  String? _selectedTimeFilter;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventsProvider>().fetchEvents(context: context);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _onSearch(String query) {
    context.read<EventsProvider>().fetchEvents(
          searchQuery: query,
          category: _selectedCategory,
          timeFilter: _selectedTimeFilter,
          context: context,
        );
  }

  void _onCategorySelected(String? category) {
    setState(() {
      _selectedCategory = category;
    });
    context.read<EventsProvider>().fetchEvents(
          category: category,
          searchQuery: _searchController.text,
          timeFilter: _selectedTimeFilter,
          context: context,
        );
  }

  void _onTimeFilterSelected(String? timeFilter) {
    setState(() {
      _selectedTimeFilter = timeFilter;
    });
    context.read<EventsProvider>().fetchEvents(
          timeFilter: timeFilter,
          category: _selectedCategory,
          searchQuery: _searchController.text,
          context: context,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to HomeScreen
          },
        ),
        title: const Text('Events'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Events'),
            Tab(text: 'Bookmarked'),
          ],
          onTap: (index) {
            if (index == 1) {
              context.read<EventsProvider>().fetchBookmarkedEvents(context);
            } else {
              context.read<EventsProvider>().fetchEvents(context: context);
            }
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildEventsList(),
          _buildEventsList(),
        ],
      ),
    );
  }

  Widget _buildEventsList() {
    return Consumer<EventsProvider>(
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
                    if (_tabController.index == 1) {
                      provider.fetchBookmarkedEvents(context);
                    } else {
                      provider.fetchEvents(context: context);
                    }
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_tabController.index == 0) ...[
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search events...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: _onSearch,
                  ),
                  const SizedBox(height: 16),
                  EventFilterBar(
                    onCategorySelected: _onCategorySelected,
                    onTimeFilterSelected: _onTimeFilterSelected,
                  ),
                  const SizedBox(height: 16),
                ],
                if (provider.events.isEmpty)
                  const Center(
                    child: Text('No events found'),
                  )
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: provider.events.length,
                    itemBuilder: (context, index) {
                      final event = provider.events[index];
                      return EventCard(
                        event: event,
                        onTap: () {
                          provider.selectEvent(event);
                          Navigator.pushNamed(
                            context,
                            '/event-details',
                            arguments: event.id,
                          );
                        },
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
