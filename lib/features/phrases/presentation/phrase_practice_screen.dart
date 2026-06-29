part of '../../../main.dart';

class PhrasePracticeScreen extends StatefulWidget {
  const PhrasePracticeScreen({
    super.key,
    required this.lang,
    required this.category,
    required this.phrases,
  });

  final AppLang lang;
  final String category;
  final List<List<String>> phrases;

  @override
  State<PhrasePracticeScreen> createState() => _PhrasePracticeScreenState();
}

class _PhrasePracticeScreenState extends State<PhrasePracticeScreen> {
  int index = 0;
  bool revealed = false;
  final Set<int> learned = {};

  bool get en => widget.lang == AppLang.en;

  void nextPhrase() {
    setState(() {
      learned.add(index);
      if (index < widget.phrases.length - 1) {
        index++;
      } else {
        index = 0;
      }
      revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final phrase = widget.phrases[index];
    final progress = learned.length / widget.phrases.length;

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
                en ? 'Phrase practice' : '표현 연습',
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
                    ? 'Practice ${widget.category} phrases you can use in real situations.'
                    : '${widget.category} 상황에서 바로 쓸 표현을 연습합니다.',
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
                    Row(
                      children: [
                        Text(
                          widget.category,
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .72),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${learned.length}/${widget.phrases.length}',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: .72),
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 10,
                        color: Colors.white,
                        backgroundColor: const Color(0x33FFFFFF),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      en ? 'Practice phrases you can copy, show, or say in real life.' : '복사해서 보여주거나 실제로 말할 수 있는 표현을 연습하세요.',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        height: 1.25,
                        letterSpacing: -0.8,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              TossCard(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Practice card ${index + 1}' : '연습 카드 ${index + 1}',
                      style: const TextStyle(
                        color: C.gray,
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      phrase[0],
                      style: const TextStyle(
                        color: C.black,
                        fontSize: 26,
                        height: 1.2,
                        letterSpacing: -0.8,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 180),
                      child: revealed
                          ? Container(
                              key: const ValueKey('revealed'),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: C.blueSoft,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                phrase[1],
                                style: const TextStyle(
                                  color: C.blue,
                                  height: 1.4,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            )
                          : Container(
                              key: const ValueKey('hidden'),
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: C.bg,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                en ? 'Tap the button below to reveal the meaning.' : '아래 버튼을 눌러 뜻을 확인하세요.',
                                style: const TextStyle(
                                  color: C.gray,
                                  height: 1.4,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              PrimaryButton(
                label: revealed ? (en ? 'I know this. Next' : '알았어요. 다음') : (en ? 'Reveal meaning' : '뜻 보기'),
                icon: revealed ? Icons.arrow_forward_rounded : Icons.visibility_rounded,
                color: revealed ? C.blue : C.blue,
                onTap: () {
                  if (revealed) {
                    nextPhrase();
                  } else {
                    setState(() => revealed = true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
