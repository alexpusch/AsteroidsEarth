define ['tutorial_view', 'desktop_tutorial_view'], (TutorialView, DesktopTutorialView) ->
  Configuration =
    Mobile:
      type: 'mobile'
      zoomRatio: 45
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
      zoomRatio: 65
      Spaceship:
        speed: 200
        angularSpeed: 40
        width: 2
        length: 3
        cannonHeatRate: 0.1
        cannonCooldownRate: 0.3
        angularDamping: 4
        linearDamping: 2
      tutorialViewType: DesktopTutorialView