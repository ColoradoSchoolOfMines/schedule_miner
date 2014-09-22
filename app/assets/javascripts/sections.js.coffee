# This code is attached to the sections partial, and is primarily used to display the section
# calendar.
#
# # Constants
# There are several numerical calculations involving weekdays in the code below, and we need to
# translate from the abbreviations in the section data to do them (then back, in order to display).
WEEKDAY_MAP = {
  'M': 1,
  'T': 2,
  'W': 3,
  'R': 4,
  'F': 5,
  'S': 6,
}

WEEKDAY_NUM_MAP = {
  1: 'M',
  2: 'T',
  3: 'W',
  4: 'R',
  5: 'F',
  6: 'S',
}

WEEKDAY_LABEL_MAP = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
}

# ## Styling options
S =
  CALENDAR:
    BACKGROUND: '#FBFBFB'
    HEIGHT_SCALE: 1
    PAD_BOTTOM: 20

  SECTION:
    LINE_HEIGHT: 20
    MARGIN_BOTTOM: 10

  SLOT:
    VERT_PADDING: 10
    # This sets the amount by which each overlapping slot is moved back onto the previous one.
    OVERLAP: 5

  TIME_DIVISION:
    COLOR: '#DDDDDD'

  TIME_DIVISION_HEAVY:
    COLOR: '#D6D6D6'

  TIME_LABEL:
    FONT: '12px "Exo 2"'
    W: 100

  WEEKDAY:
    MARGIN_LEFT: 10

  WEEKDAY_LABEL:
    FONT: 'bold 14px "Exo 2"'
    H: 50

# # Utility functions

# ## Binary search
# Taken from http://rosettacode.org/wiki/Binary_search#JavaScript.
array_findpos = (a, key, keyfunc) ->
  keyfunc ||= (x) -> x
  lo = 0
  hi = a.length - 1
  while lo <= hi
    mid = Math.floor (lo+hi)/2
    if keyfunc(a[mid]) > key
      hi = mid - 1
    else
      lo = mid + 1

  lo

window.afp = array_findpos

# ## Display
# Renders a time given in minutes as proper AM/PM
render_time = (time) ->
  hour = Math.floor(time / 60)
  minute = time % 60

  '' + ((hour + 11) % 12 + 1) + ':' + (if minute < 10 then '0' + minute else minute) + ' ' + (if hour < 12 then 'AM' else 'PM')

# Given a section, calculates a foreground/background color for it.
# TODO: Make this not, ya know, random
calculate_color = (section) ->
  r = Math.floor(Math.random() * 128)
  g = Math.floor(Math.random() * 128)
  b = Math.floor(Math.random() * 128)

  ['rgb(' + r + ',' + g + ',' + b + ')', 'white']

# # Layout
# Takes the bare section data and does the necessary layout to display it as a calendar.
#
# Note that this does not include actual pixel positioning. That is entirely up to the renderer, as
# it will vary depending on the size of the screen.
layout_calendar = (sections) ->
  # Initialize bookkeeping information. This is needed for the renderer and useful for the later
  # layout passes.
  min_time = 24*60
  max_time = 0
  min_weekday = 1
  max_weekday = 5

  # ## First pass
  # This pass finds slots for each section, where each slot covers a particular span of time on a
  # particular weekday. This allows sections covering the same period of time to be collapsed
  # together.
  #
  # The eventual result of this pass will be a set of lists, one for each weekday, containing all
  # the slots for that weekday sorted by start time.
  weekday_slots = {}
  weekday_slots[weekday] = [] for weekday in [1..6] # Might need Saturday

  # This map holds all the slots created so far, keyed by weekday and start/end time.
  weekday_time_slots = {}

  for section in sections
    # First, update bookkeeping information.
    if section.start_min < min_time then min_time = section.start_min
    if section.end_min > max_time then max_time = section.end_min
    if 'S' in section.days_of_week then max_weekday = 6

    # Each section is split up across every day of the week where it occurs.
    for day_of_week in section.days_of_week
      weekday = WEEKDAY_MAP[day_of_week]

      # Check to see if we have already created a slot for this timespan.
      key = day_of_week + section.start_min + section.end_min
      slot = weekday_time_slots[key]

      if !slot?
        # If not, we need to create it.
        #
        # The new section will need to be inserted correctly sorted into the slots for this weekday,
        # so the next pass can correctly assign it a chunk. The slots are ordered by start time,
        # then end time.
        pos = array_findpos weekday_slots[weekday], section.start_min, (slot) -> slot.start_min

        # Copy over the data from this first section.
        slot =
          sections: []
          start_min: section.start_min
          end_min: section.end_min

        # Then, we need to find all other slots that overlap with the current slot. This is used in
        # the third pass to assign columns to slots.
        overlapping_slots = []

        for other_slot in weekday_slots[weekday]
          # A slot is considered to be overlapping if it starts or ends during the current slot.
          console.log day_of_week, 'Checking other_slot', render_time(other_slot.start_min), ' - ', render_time(other_slot.end_min), 'against slot', render_time(slot.start_min), ' - ', render_time(slot.end_min), 'already', other_slot.overlapping_slots
          if not (other_slot.end_min < slot.start_min or other_slot.start_min > slot.end_min)
            console.log day_of_week, '    ... overlaps'
            overlapping_slots.push other_slot

        # We need to update the overlap information for this slot and all slots that it overlaps
        # with.
        for other_slot in overlapping_slots
          (other_slot.overlapping_slots ||= [other_slot]).push slot
          (slot.overlapping_slots ||= [slot]).push other_slot

        # Finally, we can store away the new slot in its assigned position.
        weekday_slots[weekday].splice pos, 0, slot
        weekday_time_slots[key] = slot

      # Push this section into the slot (new or otherwise).
      slot.sections.push(section)

  # ## Second pass
  # Once all of the sections have been placed in slots, they can be chunked together into chunks of
  # overlapping slots.
  weekday_chunks = {}

  for weekday in [min_weekday..max_weekday]
    weekday_chunks[weekday] = []
    # This is the current considered chunk, where the next slot will be placed if it overlaps.
    chunk = null

    for slot in weekday_slots[weekday]
      # We need to create a new chunk if there is no overlap with the current one or we haven't
      # created a chunk yet.
      if !chunk? or slot.start_min >= chunk.end_min
        # If a chunk already existed, store it away before we overwrite it.
        if chunk? then weekday_chunks[weekday].push chunk

        # Start the chunk as covering the same timespan as the current slot.
        chunk =
          start_min: slot.start_min
          end_min: slot.end_min
          slots: []

      # Extend the current chunk with the new slot.
      chunk.end_min = Math.max(chunk.end_min, slot.end_min)
      chunk.slots.push slot

    # Store away the last created chunk.
    if chunk? then weekday_chunks[weekday].push chunk

  # ## Third pass
  # This pass assigns each slot to a separate column within the chunk, so they can be displayed side
  # by side.
  max_needed_scale = 0

  for weekday in [min_weekday..max_weekday]
    for chunk in weekday_chunks[weekday]
      max_width = 1

      # Yes, we're creating another level of nesting. This is so that slots to the right will
      # correctly overlap ones to the left.
      chunk.columns = []

      # Columns are assigned by moving through the slots in (assumed) chronological order.
      for slot in chunk.slots
        taken_columns = {}
        for other_slot in (slot.overlapping_slots || [])
          if other_slot.disp_column? then taken_columns[other_slot.disp_column] = true

        slot.disp_column = 0
        slot.disp_column++ while taken_columns[slot.disp_column]

        max_width = Math.max(max_width, slot.disp_column + 1)

        (chunk.columns[slot.disp_column] ||= []).push(slot)

        slot_height = S.SLOT.VERT_PADDING * 2 + (S.SECTION.LINE_HEIGHT + S.SECTION.MARGIN_BOTTOM) * slot.sections.length
        max_needed_scale = Math.max(max_needed_scale, slot_height / (slot.end_min - slot.start_min))

      chunk.max_width = max_width

  # Finally, return an object with all of the layout information.
  min_time: min_time
  max_time: max_time
  min_weekday: min_weekday
  max_weekday: max_weekday
  weekday_chunks: weekday_chunks
  max_needed_scale: max_needed_scale

# # Rendering
# Takes precalculated layout data and renders it to the screen. Called on any screen resize.
#
# TODO:
#   * Make display a bit more compact.
#   * Add colors.
render_calendar = (layout) ->
  $calendar = $ '#section-calendar'
  $calendar.empty()

  # First, we have to determine what time span we are rendering. We round to the nearest hour for
  # simplicity's sake.
  start_time = Math.floor(layout.min_time / 60) * 60
  end_time = Math.ceil(layout.max_time / 60) * 60
  time_span = end_time - start_time
  weekday_span = (layout.max_weekday - layout.min_weekday + 1)

  # Then, we calculate the size of the calendar. The width of the calendar is determined by the
  # layout, but the height is scaled to the displayed time span.
  #
  # Before it can be fetched, though, we need to apply the padding for the time and weekday labels.
  $calendar.css
    paddingLeft: S.TIME_LABEL.W
    paddingTop: S.WEEKDAY_LABEL.H
    paddingBottom: S.CALENDAR.PAD_BOTTOM
  RENDER_WIDTH = $calendar[0].clientWidth
  C_WIDTH = RENDER_WIDTH - S.TIME_LABEL.W
  C_HEIGHT = time_span * layout.max_needed_scale
  RENDER_HEIGHT = C_HEIGHT + S.WEEKDAY_LABEL.H + S.CALENDAR.PAD_BOTTOM
  $calendar.height RENDER_HEIGHT

  PX_PER_WDAY = C_WIDTH / weekday_span
  PX_PER_MIN = C_HEIGHT / time_span

  # ## Background
  # The background, including weekday/time markers, is rendered on a canvas then applied to the
  # calendar as a background image.
  buffer = document.createElement 'canvas'
  buffer.width = $calendar[0].clientWidth
  buffer.height = RENDER_HEIGHT
  ctx = buffer.getContext '2d'

  ctx.fillStyle = S.CALENDAR.BACKGROUND
  ctx.fillRect S.TIME_LABEL.W, S.WEEKDAY_LABEL.H, C_WIDTH, C_HEIGHT

  for weekday in [layout.min_weekday..layout.max_weekday]
    ctx.font = S.WEEKDAY_LABEL.FONT
    ctx.textBaseline = 'middle'
    ctx.textAlign = 'center'
    ctx.fillStyle = 'black'
    ctx.fillText WEEKDAY_LABEL_MAP[weekday], S.TIME_LABEL.W + PX_PER_WDAY * (weekday - layout.min_weekday) + (PX_PER_WDAY - S.WEEKDAY.MARGIN_LEFT) / 2 + S.WEEKDAY.MARGIN_LEFT, S.WEEKDAY_LABEL.H / 2

  for time in [start_time..end_time] by 60
    y = S.WEEKDAY_LABEL.H + PX_PER_MIN * (time - start_time)
    ctx.strokeStyle = S.TIME_DIVISION.COLOR
    ctx.beginPath()
    ctx.lineWidth = 1
    ctx.moveTo S.TIME_LABEL.W - 10, y
    ctx.lineTo RENDER_WIDTH, y
    ctx.stroke()

    for weekday in [layout.min_weekday..layout.max_weekday]
      ctx.strokeStyle = S.TIME_DIVISION_HEAVY.COLOR
      ctx.beginPath()
      ctx.lineWidth = 2
      ctx.moveTo S.TIME_LABEL.W + PX_PER_WDAY * (weekday - layout.min_weekday) + S.WEEKDAY.MARGIN_LEFT, y
      ctx.lineTo S.TIME_LABEL.W + PX_PER_WDAY * (weekday - layout.min_weekday + 1), y
      ctx.stroke()

    ctx.font = S.TIME_LABEL.FONT
    ctx.textBaseline = 'middle'
    ctx.textAlign = 'right'
    ctx.fillStyle = 'black'
    ctx.fillText render_time(time), S.TIME_LABEL.W - 20, y

  buffer.toDataURL 'image/png'
  $calendar.css
    backgroundImage: 'url(' + buffer.toDataURL('image/png') + ')'
    backgroundRepeat: 'no-repeat'

  # ## Slots
  for weekday in [layout.min_weekday..layout.max_weekday]
    for chunk in layout.weekday_chunks[weekday]
      chunk_width = PX_PER_WDAY - S.WEEKDAY.MARGIN_LEFT
      num_slots = chunk.max_width
      slot_width = chunk_width / num_slots + (if num_slots > 1 then S.SLOT.OVERLAP / 2 else 0)

      used_columns = 0

      for column, i in chunk.columns
        for slot in column
          $slot = $('<div class="section-calendar-slot"/>').appendTo $calendar
          $slot.css
            marginLeft: PX_PER_WDAY * (weekday - layout.min_weekday) + S.WEEKDAY.MARGIN_LEFT + slot_width * i - S.SLOT.OVERLAP * i
            marginTop: PX_PER_MIN * (slot.start_min - start_time)
          $slot.width slot_width
          $slot.height PX_PER_MIN * (slot.end_min - slot.start_min)
          used_columns += slot.disp_width

          $contents = $('<div class="section-calendar-contents"><ol></ol></div>').appendTo $slot
          $contents.css
            paddingBottom: S.SLOT.VERT_PADDING
            paddingTop: S.SLOT.VERT_PADDING

          for section in slot.sections
            $section = $ '<li><b>' + section.course.department_code + ' ' + section.course.course_number + '</b> ' + section.code + '</li>'
            $section.css
              lineHeight: S.SECTION.LINE_HEIGHT + 'px'
              marginBottom: S.SECTION.MARGIN_BOTTOM
            $contents.find('ol').append $section

# # Event handlers
# When the document is ready, run the layout and rendering passes.

$(document).ready ->
  # First, retrieve the sections data from the JSON placed there by Rails.
  $sections = $ '#sections-display'
  if !$sections.length then return
  $('<div id="section-calendar" />').insertAfter $sections

  # Calculate the layout.
  layout = layout_calendar $sections.data 'sections'

  # Then, render the calendar whenever the window is resized.
  resizeTimer = null
  $(window).resize ->
    # Clear the resize timeout if it has already been set.
    clearTimeout resizeTimer if resizeTimer?

    # Then, start the timeout. This causes the resize pass to wait until the window has been the
    # same size for 100 ms.
    resizeTimer = setTimeout ( ->
      resizeTimer = null

      render_calendar layout
    ), 100

  # Also, run the layout now.
  $(window).resize()
