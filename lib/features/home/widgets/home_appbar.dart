part of '../home.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 30.0, 16.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Column(crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:const[
              const SizedBox(height: 20),
              Text(
                'Qasas-un-Nabiyīn',
                style: TextStyle(
                  fontFamily: 'Playfair',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color:AppColors.emerald,
                  letterSpacing: 1.1,
                ),
              ),
              Text(
                'قصصُ النبیین',
                style: TextStyle(
                  fontFamily: 'NotoNastaliq',
                  fontSize: 14,
                  color:AppColors.gold,
                ),
             ),
            ]
          )
        ],
      ),
    );
  }
}