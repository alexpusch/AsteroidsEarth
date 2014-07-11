define ['tutorial_view', 'desktop_tutorial_view'], (TutorialView, DesktopTutorialView) ->
  Configuration =
    Mobile:
      type: 'mobile'
      Spaceship:
        speed: 150
        angularSpeed: 100
        width: 2
        length: 3
        cannonHeatRate: 0.13
        cannonCooldownRate: 0.3
        angularDamping: 5
        linearDamping: 1.7
      tutorialViewType: TutorialView
    Desktop:
      type: 'desktop'
      Spaceship:
        speed: 150
        angularSpeed: 50
        width: 2
        length: 3
        cannonHeatRate: 0.13
        cannonCooldownRate: 0.3
        angularDamping: 4
        linearDamping: 1.5
      tutorialViewType: DesktopTutorialView