import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_application/features/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:test_application/features/calendar/domain/usecases/get_calendar_items_usecase.dart';
import 'package:test_application/features/calendar/presentation/bloc/calendar_cubit.dart';
import 'package:test_application/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:test_application/features/calendar/presentation/widgets/calendar_item_card.dart';
import 'package:test_application/features/calendar/presentation/widgets/filter_chip_button.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              CalendarCubit(GetCalendarItemsUseCase(CalendarRepositoryImpl()))
                ..loadItems(),
      child: const _CalendarView(),
    );
  }
}

class _CalendarView extends StatelessWidget {
  const _CalendarView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _AppBar(),
                const SizedBox(height: 20),
                _FilterBar(),
                const SizedBox(height: 16),
                const Expanded(child: _ItemsList()),
              ],
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _FloatingBottomNav(),
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            child: const Icon(
              Icons.arrow_back_ios,
              size: 22,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const Expanded(
            child: Text(
              'Календарь',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          const Icon(Icons.add, size: 26, color: Color(0xFF1A1A2E)),
        ],
      ),
    );
  }
}

class _FilterBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        final activeFilter = switch (state) {
          CalendarLoaded s => s.activeFilter,
          CalendarLoading s => s.activeFilter,
          _ => CalendarFilter.task,
        };

        final taskCount = state is CalendarLoaded ? state.taskCount : null;
        final eventCount = state is CalendarLoaded ? state.eventCount : null;
        final activityCount =
            state is CalendarLoaded ? state.activityCount : null;
        final cubit = context.read<CalendarCubit>();

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              FilterChipButton(
                label: 'Задачи',
                count: taskCount,
                isSelected: activeFilter == CalendarFilter.task,
                activeColor: const Color(0xFF0DA6C2),
                onTap: () => cubit.changeFilter(CalendarFilter.task),
              ),
              const SizedBox(width: 10),
              FilterChipButton(
                label: 'События',
                count: eventCount,
                isSelected: activeFilter == CalendarFilter.event,
                activeColor: const Color(0xFF61DE70),
                onTap: () => cubit.changeFilter(CalendarFilter.event),
              ),
              const SizedBox(width: 10),
              FilterChipButton(
                label: 'Мероприятия',
                count: activityCount,
                isSelected: activeFilter == CalendarFilter.activity,
                activeColor: const Color(0xFFFFC239),
                onTap: () => cubit.changeFilter(CalendarFilter.activity),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ItemsList extends StatelessWidget {
  const _ItemsList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        if (state is CalendarInitial || state is CalendarLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFF4A90D9)),
          );
        }

        if (state is CalendarError) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.redAccent,
                ),
                const SizedBox(height: 12),
                Text(state.message),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<CalendarCubit>().loadItems(),
                  child: const Text('Повторить'),
                ),
              ],
            ),
          );
        }

        if (state is CalendarLoaded) {
          if (state.items.isEmpty) {
            return const Center(
              child: Text(
                'Нет элементов',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.only(top: 0, bottom: 100),
            itemCount: state.items.length,
            itemBuilder: (_, i) => CalendarItemCard(item: state.items[i]),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _FloatingBottomNav extends StatelessWidget {
  const _FloatingBottomNav();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: const Color(0xFF828282),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  _NavIcon(icon: Icons.home_outlined, isActive: false),
                  _NavIcon(
                    icon: Icons.insert_drive_file_outlined,
                    isActive: false,
                  ),
                  _NavIcon(icon: Icons.group_outlined, isActive: false),
                  _NavIcon(icon: Icons.alarm, isActive: true),
                  _NavIcon(icon: Icons.person_outline, isActive: false),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;

  const _NavIcon({required this.icon, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final color =
        isActive ? const Color(0xFF00BCD4) : Colors.white.withOpacity(0.85);
    return Icon(icon, size: 28, color: color);
  }
}
