part of '../../../main.dart';

class PointHistoryScreen extends StatefulWidget {
  const PointHistoryScreen({super.key, required this.lang});
  final AppLang lang;
  @override
  State<PointHistoryScreen> createState() => _PointHistoryScreenState();
}

class _PointHistoryScreenState extends State<PointHistoryScreen> {
  bool get en => widget.lang == AppLang.en;
  List<Map<String, dynamic>> _history = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final res = await ApiClient.dio.get('/api/members/me/points/history');
      if (res.data['isSuccess'] == true) {
        setState(() {
          _history = List<Map<String, dynamic>>.from(res.data['result']);
          _loading = false;
        });
        return;
      }
    } catch (_) {}
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
              ),
              const SizedBox(height: 18),
              Text(
                en ? 'Point history' : '포인트 내역',
                style: const TextStyle(
                  color: C.black,
                  fontSize: 31,
                  height: 1.1,
                  letterSpacing: -1.2,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                en ? 'See where your points came from.' : '포인트를 어디서 얻었는지 확인해요.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              ValueListenableBuilder<UserProgressState>(
                valueListenable: userProgress,
                builder: (context, state, _) {
                  final progressValue = state.points > 0
                      ? (state.points % 1000) / 1000.0
                      : 0.0;
                  return TossCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          en ? 'Current points' : '현재 포인트',
                          style: const TextStyle(
                            color: C.gray,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${state.points}P',
                          style: const TextStyle(
                            color: C.black,
                            fontSize: 34,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1.2,
                          ),
                        ),
                        const SizedBox(height: 14),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: LinearProgressIndicator(
                            value: progressValue,
                            minHeight: 10,
                            color: C.blue,
                            backgroundColor: C.blueSoft,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Header(title: en ? 'Recent activity' : '최근 적립 내역'),
              if (_loading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_history.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      en ? 'No history yet.' : '아직 적립 내역이 없어요.',
                      style: const TextStyle(color: C.gray, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              else
                ..._history.map(
                  (item) => ListRow(
                    icon: Icons.add_rounded,
                    iconColor: C.blue,
                    iconBg: C.blueSoft,
                    title: item['description'] ?? '',
                    subtitle: '+${item['points']}P',
                    onTap: () => toast(context, '+${item['points']}P'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
