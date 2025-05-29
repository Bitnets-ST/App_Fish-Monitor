import 'package:flutter/material.dart';
import '../models/fish.dart';
import '../services/mongodb_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Fish> _fish = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFish();
  }

  Future<void> _loadFish() async {
    try {
      final fish = await MongoDBService.getAllFish();
      setState(() {
        _fish = fish;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading fish: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fish Monitor'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadFish,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _fish.isEmpty
              ? const Center(child: Text('No fish found'))
              : ListView.builder(
                  itemCount: _fish.length,
                  itemBuilder: (context, index) {
                    final fish = _fish[index];
                    return ListTile(
                      title: Text(fish.name),
                      subtitle: Text(fish.species),
                      trailing: Text('${fish.weight}kg'),
                      onTap: () {
                        // TODO: Navigate to fish details
                      },
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Navigate to add fish screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 