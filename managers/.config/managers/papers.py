import argparse
from pathlib import Path
from rofi import Rofi


def launch_alacritty(notes_file, notesdir):
    # Get the relative path
    rel_path = notes_file.relative_to(notesdir)

    # Launch alacritty
    import subprocess
    subprocess.Popen(['alacritty',
                      '-t "diary"',
                      '--working-directory', str(notesdir),
                      '-e', 'nvim', rel_path])


def launch_zathura(pdf_file):
    # Launch alacritty
    import subprocess
    subprocess.Popen(['zathura', str(pdf_file)])


def open_note(launch=True, verbose=False):
    # Get the notes
    notes_files = sorted(notesdir.glob("**/*.md"))
    headers = {}
    for notes_file in notes_files:
        with open(notes_file) as f:
            first_line = f.readline().strip('#').strip()
            headers[first_line] = notes_file

    # Get choice
    selection, _ = r.select('>', sorted(headers.keys()))

    if (selection not in headers) & (len(selection) > 0):
        _selection = selection.replace(" ", "-")  # type: ignore
        note_file = notesdir / f"{_selection}.md"
        note_file.write_text(f'# {selection}')
        headers[selection] = note_file

    if verbose:
        print(f'headers[selection]: {headers[selection]}')

    if launch:
        launch_alacritty(headers[selection], notesdir)


def open_paper(launch=True, verbose=False):

    # Get the papers
    pdf_files = sorted(papersdir.glob("**/*.pdf"))
    headers = {v.stem: v for v in pdf_files}

    # Get choice
    selection, _ = r.select('>', list(headers.keys()))

    if verbose:
        print(f'headers[selection]: {headers[selection]}')  # type: ignore

    if launch:
        launch_zathura(headers[selection])  # type: ignore


if __name__ == "__main__":
    # Open note or paper
    parser = argparse.ArgumentParser(description='Launch papers and relevant notes')
    parser.add_argument('-d', '--dtype',
                        help='Document type',
                        default='notes')
    parser.add_argument('-s', '--src_dir',
                        help='Document type',
                        default='/home/x/codebase/eljou')
    args = parser.parse_args()

    # Directories
    root_dir = Path(args.src_dir)
    notesdir = root_dir / 'notes'
    papersdir = root_dir / 'papers'
    r = Rofi()

    launchers = {
        'notes': open_note,
        'papers': open_paper
    }

    launchers[args.dtype]()
