part of '../../../main.dart';

class WritePostScreen extends StatefulWidget {
  const WritePostScreen({
    super.key,
    required this.lang,
  });

  final AppLang lang;

  @override
  State<WritePostScreen> createState() => _WritePostScreenState();
}

class _WritePostScreenState extends State<WritePostScreen> {
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  BoardFilter selectedBoard = BoardFilter.qna;
  int selectedCategory = 0;

  bool get en => widget.lang == AppLang.en;

  final koCategories = const ['교통', '배달', '행정', '병원', '은행', '분리수거'];
  final enCategories = const ['Transport', 'Delivery', 'Admin', 'Clinic', 'Bank', 'Waste'];

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  void submitPost() {
    final title = titleController.text.trim();
    final body = bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      toast(
        context,
        en ? 'Please enter both title and content.' : '제목과 내용을 모두 입력해주세요.',
      );
      return;
    }

    communityPosts.value = [
      CommunityPost(
        board: selectedBoard,
        titleKo: title,
        titleEn: title,
        metaKo: '방금 전 · 댓글 0 · 추천 0 · ${koCategories[selectedCategory]}',
        metaEn: 'Just now · 0 replies · 0 likes · ${enCategories[selectedCategory]}',
      ),
      ...communityPosts.value,
    ];

    toast(
      context,
      en ? 'Post added to the community.' : '커뮤니티에 글이 추가되었습니다.',
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final categories = en ? enCategories : koCategories;

    return Scaffold(
      backgroundColor: C.bg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(22, 18, 22, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(18),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: C.black,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      en ? 'Write post' : '글쓰기',
                      style: const TextStyle(
                        color: C.black,
                        fontSize: 28,
                        letterSpacing: -1,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              TossCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      en ? 'Ask with context' : '어디서 막혔는지 알려주세요',
                      style: const TextStyle(
                        color: C.black,
                        fontSize: 19,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      en
                          ? 'Questions with location, situation, and what you tried are easier for helpers to answer.'
                          : '앱 이름, 장소, 화면에 나온 문구를 적으면 더 정확한 답변을 받을 수 있어요.',
                      style: const TextStyle(
                        color: C.gray,
                        height: 1.45,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Header(title: en ? 'Board type' : '게시판 선택'),
              FilterBar(
                labels: en ? const ['Free board', 'Q&A'] : const ['자유게시판', 'Q&A'],
                selected: selectedBoard.index,
                onTap: (i) => setState(() => selectedBoard = BoardFilter.values[i]),
              ),
              Header(title: en ? 'Category' : '카테고리'),
              FilterBar(
                labels: categories,
                selected: selectedCategory,
                onTap: (i) => setState(() => selectedCategory = i),
              ),
              Header(title: en ? 'Post content' : '게시글 내용'),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: en
                      ? 'Example: My delivery address keeps failing'
                      : '예: 배달앱 주소 입력이 계속 실패해요',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bodyController,
                minLines: 6,
                maxLines: 9,
                decoration: InputDecoration(
                  hintText: en
                      ? 'Write the situation, location, and what you already tried.'
                      : '어떤 화면에서 막혔는지, 어떤 문구가 나왔는지 적어주세요.',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(22),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              TossCard(
                child: Row(
                  children: [
                    IconBox(
                      icon: Icons.tips_and_updates_rounded,
                      color: C.blue,
                      bg: C.blueSoft,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        en
                            ? 'Tip: Add a screenshot or exact Korean phrase later when backend upload is ready.'
                            : '팁: 추후 백엔드 업로드가 연결되면 스크린샷이나 한국어 문구도 함께 첨부할 수 있습니다.',
                        style: const TextStyle(
                          color: C.gray,
                          height: 1.4,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              PrimaryButton(
                label: en ? 'Submit post' : '게시글 등록하기',
                icon: Icons.send_rounded,
                onTap: submitPost,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TossTextField extends StatelessWidget {
  const TossTextField({
    super.key,
    required this.hint,
    this.maxLines = 1,
  });

  final String hint;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: const BorderSide(color: C.blue, width: 1.5),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(22),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
