;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(specifications->manifest
  (list "python-tqdm"
        "python-scikit-image"
        "python-scikit-learn"
        "python-scipy"
        "python-pyserial"
        "python-pycryptodome"
        "python-pycrypto"
        "python-protobuf"
        "python-pandas"
        "python-lxml"
        "jupyter"
        "python-h5py"
        "python-coverage"
        "python-bitarray"
        "python"))
