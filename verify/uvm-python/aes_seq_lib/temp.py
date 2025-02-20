import os
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.backends import default_backend

# Function to encrypt a single block using AES in ECB mode
def encrypt_aes_ecb(block, key):
    cipher = Cipher(algorithms.AES(key), modes.ECB(), backend=default_backend())
    encryptor = cipher.encryptor()
    cipher_text = encryptor.update(block) + encryptor.finalize()
    return cipher_text

# Function to decrypt a single block using AES in ECB mode
def decrypt_aes_ecb(cipher_text, key):
    cipher = Cipher(algorithms.AES(key), modes.ECB(), backend=default_backend())
    decryptor = cipher.decryptor()
    decrypted_block = decryptor.update(cipher_text) + decryptor.finalize()
    return decrypted_block

# User Input: Select AES-128 or AES-256
key_size = int(input("Enter key size (128 or 256): "))
if key_size not in [128, 256]:
    raise ValueError("Invalid key size! Only 128 or 256 are supported.")

# Generate a random key with the appropriate length
if key_size == 128:
    key = 0x2B7E151628AED2A6ABF7158809CF4F3C
elif key_size == 256:
    key = os.urandom(32)  # 32 bytes for AES-256

# Print the generated key in hex format
print(f"Generated Key (Hex): {hex(key)}")

# Hexadecimal input for block
block_hex = 0x6bc1bee22e409f96e93d7e117393172a
block = block_hex.to_bytes(16, byteorder='big')
key = key.to_bytes(16, byteorder='big')

# Encrypt the block
cipher_text = encrypt_aes_ecb(block, key)
print(f"Cipher Text (Hex): {cipher_text.hex().upper()}")

# Decrypt the block
decrypted_block = decrypt_aes_ecb(cipher_text, key)
print(f"Decrypted Block (Hex): {decrypted_block.hex().upper()}")

# Verify that decryption is correct
if decrypted_block == block:
    print("Decryption successful! Original block restored.")
else:
    print("Decryption failed. Something went wrong.")
