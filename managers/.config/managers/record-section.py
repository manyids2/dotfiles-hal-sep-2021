import argparse
import subprocess
from pathlib import Path
from rofi import Rofi

session_dir = Path('/home/x/fd/sessions/transcribe')
root_dir = Path('/home/x/musescore/transcribe')
r = Rofi()


def get_subdirs(root_dir, makedir=True):
    # Get the names
    subdirs = sorted([_d for _d in root_dir.iterdir() if _d.is_dir()])

    # Get headers
    headers = {}
    for subdir in subdirs:
        headers[subdir.stem] = subdir

    # Choose
    subdir, _ = r.select('>', list(headers.keys()))

    # If new artist/song
    if (subdir not in headers) & (len(subdir) > 0):
        chosen_dir = root_dir / subdir
        headers[subdir] = chosen_dir

        if makedir:
            chosen_dir.mkdir(exist_ok=True)

    return headers[subdir]


def launch_brainstorm():
    # Check MIDI devices
    output = subprocess.run(['lsmidiins'], stdout=subprocess.PIPE).stdout.decode('utf-8')
    output = [_o.strip() for _o in output.split('\n')[:-1]]

    # Check if we have Digital Piano
    names = {int(_o.split(' ')[0]): _o.split(':')[1] for _o in output}
    print(f'names: {names}')
    assert len(names) > 0
    if 'Digital Piano MIDI 1' not in names.values():
        subprocess.Popen(['notify-send', 'Digital Piano MIDI 1 not connected'])
        raise RuntimeError

    # Get the rec dir
    sections_dir = get_sections_dir()

    # Launch brainstorm
    subprocess.Popen(['brainstorm',
                      '--in', '1',
                      '--prefix', f'{sections_dir}/'])

    subprocess.Popen(['notify-send', f'Launched: {sections_dir}'])


def kill_brainstorm():
    # Launch brainstorm
    subprocess.Popen(['killall', 'brainstorm'])
    subprocess.Popen(['notify-send', f'Killed session'])


def get_sections_dir(makedir=True):
    # Get artist_dir
    artist_dir = get_subdirs(root_dir)
    song_dir = get_subdirs(artist_dir)

    sections_dir = song_dir / 'sections'

    if makedir:
        sections_dir.mkdir(exist_ok=True)

    return sections_dir


if __name__ == "__main__":
    # Get the day
    parser = argparse.ArgumentParser(description='Launch recording')
    parser.add_argument('-s', '--state',
                        help='Description for foo argument',
                        default='test')
    args = parser.parse_args()

    ACTIONS = {
        'on': launch_brainstorm,
        'off': kill_brainstorm,
    }

    ACTIONS[args.state]()
