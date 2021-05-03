Rails.configuration.stripe = {
  :publishable_key => "pk_test_51ImtmBSDWHjTZeZl6FcP6GXhrtMinjTGvhgWPsghNsvhJZQCdfukOS1ciLY2ck5VmVbGyx1Hv1ELuNDDEnKFBZwJ00n0gvjWUa",
  :secret_key      => "sk_test_51ImtmBSDWHjTZeZlAtpqnulrHzFspHYJjycq10HlpoXGxyk5T1UQ3G9C9wRFD9xJMkGWPpKeV49W5HUJXPJY3FAw006xPX8VDR"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]