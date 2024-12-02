import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/paper_provider.dart';
import '../theme/colors.dart';
import '../widgets/paper_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  // Animation controller for fade effect
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  bool _isSearching = false; // Track search bar state for animation

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 500), // Animation duration
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final paperProvider = Provider.of<PaperProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Hero(
          tag: 'appTitle', // Match tag with HomeScreen for smooth transition
          child: Text('Search Papers'),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300), // Animation duration
            color: _isSearching
                ? AppColors.accent.withOpacity(0.2) // Highlighted color
                : Colors.transparent,
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              onTap: () {
                setState(() {
                  _isSearching = true; // Activate animation on tap
                });
              },
              onSubmitted: (query) async {
                await _performSearch(context, paperProvider, query);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      _isSearching = false;
                    });
                    _performSearch(context, paperProvider, '');
                  },
                ),
                filled: true,
                fillColor: AppColors.primaryBackground,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _performSearch(context, paperProvider, _controller.text);
            },
            child: const Text('Search'),
          ),
          Expanded(
            child: Consumer<PaperProvider>(
              builder: (context, paperProvider, child) {
                if (paperProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (paperProvider.error.isNotEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'An error occurred while searching:',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          paperProvider.error,
                          style: const TextStyle(color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            _performSearch(
                                context, paperProvider, _controller.text);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (paperProvider.papers.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'No papers found.',
                          style: TextStyle(color: AppColors.textPrimary),
                        ),
                        const SizedBox(height: 8.0),
                        const Text(
                          'Please try a different query.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            _controller.clear();
                            _performSearch(context, paperProvider, '');
                          },
                          child: const Text('Clear Search'),
                        ),
                      ],
                    ),
                  );
                }

                return FadeTransition(
                  opacity: _fadeAnimation, // Apply fade animation
                  child: ListView.separated(
                    itemCount: paperProvider.papers.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1, color: Colors.grey),
                    itemBuilder: (context, index) {
                      final paper = paperProvider.papers[index];
                      return PaperCard(
                        paper: paper, // Pass the Paper object directly
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performSearch(
      BuildContext context, PaperProvider provider, String query) async {
    if (query.trim().isNotEmpty) {
      await provider.fetchArticles(query.trim()); // Perform the search
      _fadeController.forward(); // Start fade animation
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a search query.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }
}
