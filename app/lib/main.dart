// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/network/api_client.dart';
import 'core/network/api_endpoints.dart';
import 'core/network/token_storage.dart';
import 'core/services/auth_service.dart';

part 'app/k_life_guide_app.dart';
part 'app/tabs.dart';

part 'core/theme/app_colors.dart';
part 'core/models/app_enums.dart';

part 'features/community/domain/community_post.dart';
part 'features/profile/domain/user_progress_state.dart';
part 'features/missions/domain/mission.dart';

part 'features/community/data/community_mock_data.dart';
part 'features/profile/data/user_progress_store.dart';
part 'features/missions/data/mission_mock_data.dart';

part 'features/auth/presentation/login_page.dart';

part 'features/home/presentation/home_screen.dart';
part 'features/home/presentation/today_checklist_screen.dart';
part 'features/home/presentation/widgets/service_toolkit_card.dart';
part 'features/home/presentation/widgets/emergency_quick_card.dart';
part 'features/home/presentation/widgets/today_brief_card.dart';
part 'features/home/presentation/widgets/k_life_passport_card.dart';
part 'features/home/presentation/widgets/survival_phrase_card.dart';
part 'features/home/presentation/widgets/settlement_roadmap_card.dart';

part 'features/missions/presentation/mission_screen.dart';
part 'features/missions/presentation/mission_detail_screen.dart';
part 'features/missions/presentation/verify_screen.dart';
part 'features/missions/presentation/widgets/mission_insight_card.dart';
part 'features/missions/presentation/widgets/mission_card.dart';

part 'features/community/presentation/community_screen.dart';
part 'features/community/presentation/post_detail_screen.dart';
part 'features/community/presentation/write_post_screen.dart';
part 'features/community/presentation/widgets/community_pulse_card.dart';
part 'features/community/presentation/widgets/post_tile.dart';

part 'features/profile/presentation/profile_screen.dart';
part 'features/profile/presentation/completed_missions_screen.dart';
part 'features/profile/presentation/point_history_screen.dart';
part 'features/profile/presentation/badge_collection_screen.dart';
part 'features/profile/presentation/my_posts_screen.dart';
part 'features/profile/presentation/passport_screen.dart';
part 'features/profile/presentation/widgets/profile_card.dart';
part 'features/profile/presentation/widgets/profile_common_widgets.dart';

part 'features/phrases/presentation/survival_phrase_screen.dart';
part 'features/phrases/presentation/phrase_practice_screen.dart';

part 'features/roadmap/presentation/settlement_roadmap_screen.dart';

part 'shared/widgets/page_shell.dart';
part 'shared/widgets/toss_card.dart';
part 'shared/widgets/icon_box.dart';
part 'shared/widgets/header.dart';
part 'shared/widgets/filter_bar.dart';
part 'shared/widgets/feature_card.dart';
part 'shared/widgets/primary_button.dart';
part 'shared/widgets/lang_button.dart';
part 'shared/navigation/app_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const KLifeGuideApp());
}
