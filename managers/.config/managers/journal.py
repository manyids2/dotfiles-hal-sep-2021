from pathlib import Path
from datetime import datetime, timedelta
import argparse


month_names = {
    1: 'Jan', 2: 'Feb', 3: 'Mar',
    4: 'Apr', 5: 'May', 6: 'Jun',
    7: 'Jul', 8: 'Aug', 9: 'Sep',
    10: 'Oct', 11: 'Nov', 12: 'Dec',
}


def get_index_file_text(diary_dir):
    # List the files
    md_files = sorted(list(diary_dir.glob(r'**/[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9].md')))
    diary_files = {}
    for md_file in md_files:
        # Sort by year, month, date
        year, month, day = md_file.stem.split('-')

        # Init the year/month
        if year not in diary_files:
            diary_files[year] = {}
        if month not in diary_files[year]:
            diary_files[year][month] = {}

        # Save the path
        diary_files[year][month][day] = md_file

    def _sorted_keys(_dict):
        return sorted(list(_dict.keys()))[::-1]

    # Write out the list
    out_lines = []
    out_lines.append(f'# Diary')
    years = _sorted_keys(diary_files)
    for year in years:
        # Year as subheading
        out_lines.append(f'\n## {year}')
        months = _sorted_keys(diary_files[year])
        for month in months:
            out_lines.append(f'\n### {month_names[int(month)]}, {year}\n')
            days = _sorted_keys(diary_files[year][month])
            for day in days:
                # Read the headers
                with open(str(diary_files[year][month][day])) as f:
                    first_line = f.readline().strip('#').strip()
                    rel_path = diary_files[year][month][day].relative_to(diary_dir)
                    out_lines.append(f'- [{first_line}]({rel_path})')

    return '\n'.join(out_lines)


def write_index_file(index_file, diary_dir):
    out_lines = get_index_file_text(diary_dir)
    index_file.write_text(out_lines)
    return index_file


def get_year_month_day(now):
    # In the proper format
    year = now.strftime("%Y")
    month = now.strftime("%m")
    day = now.strftime("%d")
    return year, month, day


def ensure_directories(year, month, diary_dir):
    # Ensure directories exist
    year_dir = diary_dir / year
    year_dir.mkdir(exist_ok=True)

    month_dir = year_dir / month
    month_dir.mkdir(exist_ok=True)


def open_day(today, diary_dir):
    # 2021/04/2021-04-30.md
    year, month, day = get_year_month_day(today)

    # Make sure directories exist
    ensure_directories(year, month, diary_dir)

    # Check the file
    day_file = diary_dir / year / month / f'{year}-{month}-{day}.md'

    # If it already exists, just open it, else
    if not day_file.is_file():
        weekday = today.strftime("%a %d %b")
        header = f'# {weekday}'
        day_file.write_text(header)
        print(f'Created {day_file}.')
        print(day_file.read_text())
    else:
        print(f'{day_file} already exists.')
        print(day_file.read_text())

    return day_file


def launch_kitty(day_file, diary_dir):
    # Get the relative path
    rel_path = day_file.relative_to(diary_dir)

    # Launch kitty
    import subprocess
    subprocess.Popen(['kitty',
                      '-T', 'diary',
                      '--directory', diary_dir,
                      'nvim', rel_path])


if __name__ == "__main__":
    # Get the day
    parser = argparse.ArgumentParser(description='Launch diary')
    parser.add_argument('-d', '--day',
                        help='Description for foo argument',
                        default='index')
    parser.add_argument('-s', '--src_dir',
                        help='Root directory',
                        default='/home/x/codebase/eljou')
    args = parser.parse_args()

    root_dir = Path(args.src_dir)

    # Gather diary links
    diary_dir = root_dir / 'diary'

    # Rewrite index file everytime
    index_file = diary_dir / 'index.md'
    day_file = write_index_file(index_file, diary_dir)

    if args.day != 'index':
        days = {
            'today': datetime.today(),
            'yesterday': datetime.today() - timedelta(days=1),
            'tomorrow': datetime.today() + timedelta(days=1),
        }
        day_file = open_day(days[args.day], diary_dir)

    launch_kitty(day_file, diary_dir)
