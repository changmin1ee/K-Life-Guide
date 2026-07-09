part of '../../../main.dart';

class SurvivalPhraseScreen extends StatefulWidget {
  const SurvivalPhraseScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  @override
  State<SurvivalPhraseScreen> createState() => _SurvivalPhraseScreenState();
}

class _SurvivalPhraseScreenState extends State<SurvivalPhraseScreen> {
  int selected = 0;
  final Set<int> savedPhraseIds = {};

  // API 데이터
  List<Map<String, dynamic>> _apiCategories = [];
  bool _loadingPhrases = true;

  bool get en => widget.lang == AppLang.en;

  @override
  void initState() {
    super.initState();
    _loadPhrases();
  }

  Future<void> _loadPhrases() async {
    try {
      final res = await ApiClient.dio.get('/api/phrases');
      if (res.data['isSuccess'] == true) {
        final categories =
            List<Map<String, dynamic>>.from(res.data['result']);
        // isSaved 기반으로 초기 savedPhraseIds 세팅
        final ids = categories
            .expand((c) => (c['phrases'] as List? ?? []))
            .where((p) => p['isSaved'] == true)
            .map((p) => p['id'] as int)
            .toSet();
        setState(() {
          _apiCategories = categories;
          savedPhraseIds.addAll(ids);
          _loadingPhrases = false;
        });
        return;
      }
    } catch (_) {}
    setState(() => _loadingPhrases = false);
  }

  // 즐겨찾기 토글 (API 호출 + 로컬 상태 갱신)
  Future<void> _toggleSave(
      int phraseId, bool currentlySaved) async {
    // 로컬 상태 즉시 반영 (낙관적 업데이트)
    setState(() {
      if (currentlySaved) {
        savedPhraseIds.remove(phraseId);
      } else {
        savedPhraseIds.add(phraseId);
      }
    });

    try {
      if (currentlySaved) {
        await ApiClient.dio.delete('/api/phrases/$phraseId/save');
      } else {
        await ApiClient.dio.post('/api/phrases/$phraseId/save');
      }
    } catch (_) {
      // API 실패 시 롤백
      setState(() {
        if (currentlySaved) {
          savedPhraseIds.add(phraseId);
        } else {
          savedPhraseIds.remove(phraseId);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // API 데이터 기반 카테고리/표현 목록
    final categories = _apiCategories.isEmpty
        ? <String>[]
        : _apiCategories
            .map((c) => (en ? c['enName'] : c['koName']) as String? ?? '')
            .toList();

    // 선택된 카테고리의 표현 목록 (API 데이터)
    List<Map<String, dynamic>> currentPhrases = [];
    List<List<String>> current = [];
    if (_apiCategories.isNotEmpty && selected < _apiCategories.length) {
      final phraseList =
          (_apiCategories[selected]['phrases'] as List?) ?? [];
      currentPhrases = phraseList.cast<Map<String, dynamic>>();
      current = currentPhrases
          .map((p) => [
                (en ? p['enText'] : p['koText']) as String? ?? '',
                (en ? p['enHint'] : p['koHint']) as String? ?? '',
              ])
          .toList();
    }

    final currentSavedCount = currentPhrases
        .where((p) => savedPhraseIds.contains(p['id'] as int?))
        .length;

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
                en ? 'Survival phrases' : '생활 필수 표현',
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
                en
                    ? 'Short Korean phrases you can show or say in real situations.'
                    : '실제 상황에서 보여주거나 말할 수 있는 짧은 한국어 표현입니다.',
                style: const TextStyle(
                  color: C.gray,
                  fontSize: 15,
                  height: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: C.black,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1F0F1E3A),
                      blurRadius: 24,
                      offset: Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Quick use mode' : '빠른 사용 모드',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .72),
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      en
                          ? 'Tap a phrase to save it, or copy it to show someone.'
                          : '저장하거나 복사해서 기사님, 직원, 약사에게 바로 보여주세요.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        height: 1.22,
                        letterSpacing: -0.8,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      en
                          ? 'These phrases are written for real situations: taxis, delivery, clinics, banks, and emergencies.'
                          : '발음이 어렵거나 급할 때 화면을 보여주는 방식으로 사용할 수 있어요.',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: .72),
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              if (_loadingPhrases)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (categories.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Text(
                      en ? 'No phrases available.' : '표현을 불러올 수 없어요.',
                      style: const TextStyle(
                          color: C.gray, fontWeight: FontWeight.w700),
                    ),
                  ),
                )
              else ...[
                FilterBar(
                  labels: categories,
                  selected: selected,
                  onTap: (i) => setState(() => selected = i),
                ),
                Header(
                  title: en ? 'Useful phrases' : '유용한 표현',
                  action: '$currentSavedCount/${current.length}',
                ),
                ...currentPhrases.asMap().entries.map(
                  (entry) {
                    final p = current[entry.key];
                    final phraseData = entry.value;
                    final phraseId = phraseData['id'] as int?;
                    final saved = phraseId != null && savedPhraseIds.contains(phraseId);

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          if (phraseId == null) return;
                          final wasSaved = saved;
                          _toggleSave(phraseId, wasSaved);
                          toast(
                            context,
                            wasSaved
                                ? (en
                                    ? 'Phrase removed from favorites.'
                                    : '저장한 표현을 해제했습니다.')
                                : (en
                                    ? 'Phrase saved to favorites.'
                                    : '표현을 즐겨찾기에 저장했습니다.'),
                          );
                        },
                        borderRadius: BorderRadius.circular(28),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          decoration: BoxDecoration(
                            color: saved ? C.blueSoft : Colors.white,
                            borderRadius: BorderRadius.circular(28),
                            border:
                                Border.all(color: saved ? C.blueSoft : Colors.white),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x0D000000),
                                blurRadius: 18,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              IconBox(
                                icon: saved
                                    ? Icons.bookmark_rounded
                                    : Icons.translate_rounded,
                                color: C.blue,
                                bg: saved ? Colors.white : C.blueSoft,
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      p[0],
                                      style: const TextStyle(
                                        color: C.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      p[1],
                                      style: const TextStyle(
                                        color: C.gray,
                                        fontSize: 13,
                                        height: 1.35,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                saved
                                    ? Icons.bookmark_rounded
                                    : Icons.bookmark_add_outlined,
                                color: saved ? C.blue : C.gray,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: en ? 'Practice with flashcards' : '플래시카드로 연습하기',
                  icon: Icons.school_rounded,
                  color: C.blue,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PhrasePracticeScreen(
                        lang: widget.lang,
                        category: categories[selected],
                        phrases: current,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
